const std = @import("std");

pub const TokenType = enum {
    command,
    short_flag,
    long_flag,
    argument,
    pipe,
    redirect,
};

pub const Token = struct {
    slice: []const u8,
    tok_type: TokenType,
};

/// High-speed zero-allocation linear tokenizer
pub const Lexer = struct {
    source: []const u8,
    cursor: usize = 0,

    pub fn init(source: []const u8) Lexer {
        return Lexer{ .source = source };
    }

    pub fn next(self: *Lexer) ?Token {
        self.skipWhitespace();
        if (self.cursor >= self.source.len) return null;

        const start = self.cursor;
        const first = self.source[self.cursor];

        // Pipe operator
        if (first == '|') {
            self.cursor += 1;
            return Token{ .slice = self.source[start..self.cursor], .tok_type = .pipe };
        }

        // Redirection
        if (first == '>' or first == '<') {
            self.cursor += 1;
            if (self.cursor < self.source.len and self.source[self.cursor] == '>') {
                self.cursor += 1;
            }
            return Token{ .slice = self.source[start..self.cursor], .tok_type = .redirect };
        }

        // Quoted string
        if (first == '\'' or first == '"') {
            const quote = first;
            self.cursor += 1;
            const content_start = self.cursor;
            while (self.cursor < self.source.len and self.source[self.cursor] != quote) {
                if (self.source[self.cursor] == '\\' and self.cursor + 1 < self.source.len) {
                    self.cursor += 2;
                } else {
                    self.cursor += 1;
                }
            }
            const content_end = self.cursor;
            if (self.cursor < self.source.len) self.cursor += 1; // consume closing quote
            return Token{
                .slice = self.source[content_start..content_end],
                .tok_type = .argument,
            };
        }

        // Regular word / flag
        while (self.cursor < self.source.len and !std.ascii.isWhitespace(self.source[self.cursor]) and self.source[self.cursor] != '|' and self.source[self.cursor] != '>' and self.source[self.cursor] != '<') {
            self.cursor += 1;
        }

        const raw = self.source[start..self.cursor];
        if (std.mem.startsWith(u8, raw, "--") and raw.len > 2) {
            return Token{ .slice = raw, .tok_type = .long_flag };
        } else if (std.mem.startsWith(u8, raw, "-") and raw.len > 1) {
            return Token{ .slice = raw, .tok_type = .short_flag };
        } else if (start == 0) {
            return Token{ .slice = raw, .tok_type = .command };
        } else {
            return Token{ .slice = raw, .tok_type = .argument };
        }
    }

    fn skipWhitespace(self: *Lexer) void {
        while (self.cursor < self.source.len and std.ascii.isWhitespace(self.source[self.cursor])) {
            self.cursor += 1;
        }
    }
};

/// Expands bundled short flags like `-czf` into individual `-c`, `-z`, `-f`
pub const FlagSplitter = struct {
    raw: []const u8,
    index: usize = 1,

    pub fn init(raw: []const u8) ?FlagSplitter {
        if (!std.mem.startsWith(u8, raw, "-") or std.mem.startsWith(u8, raw, "--") or raw.len <= 1) {
            return null;
        }
        return FlagSplitter{ .raw = raw };
    }

    pub fn next(self: *FlagSplitter, buf: *[2]u8) ?[]const u8 {
        if (self.index >= self.raw.len) return null;
        buf[0] = '-';
        buf[1] = self.raw[self.index];
        self.index += 1;
        return buf[0..2];
    }
};
