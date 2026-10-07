const std = @import("std");
const buffer = @import("buffer.zig");
const Grid = buffer.Grid;
const Cell = buffer.Cell;
const Color = buffer.Color;

pub const Renderer = struct {
    front: Grid,
    back: Grid,
    allocator: std.mem.Allocator,

    fn writeStdout(bytes: []const u8) void {
        _ = std.c.write(1, bytes.ptr, bytes.len);
    }

    fn printStdout(comptime fmt: []const u8, args: anytype) void {
        var buf: [256]u8 = undefined;
        const str = std.fmt.bufPrint(&buf, fmt, args) catch return;
        writeStdout(str);
    }

    pub fn init(allocator: std.mem.Allocator, width: usize, height: usize) !Renderer {
        const front = try Grid.init(allocator, width, height);
        const back = try Grid.init(allocator, width, height);

        // Hide cursor and enter alternate screen buffer
        writeStdout("\x1b[?1049h\x1b[?25l");

        return Renderer{
            .front = front,
            .back = back,
            .allocator = allocator,
        };
    }

    pub fn deinit(self: *Renderer) void {
        // Restore main screen buffer and show cursor
        writeStdout("\x1b[?25h\x1b[?1049l");
        self.front.deinit();
        self.back.deinit();
    }

    /// Differential line flush: compares front vs back and emits ANSI sequences strictly for changed cells
    pub fn flush(self: *Renderer) !void {
        var last_fg: Color = .default;
        var last_attr: u8 = 0;
        var cursor_x: usize = std.math.maxInt(usize);
        var cursor_y: usize = std.math.maxInt(usize);

        var y: usize = 0;
        while (y < self.back.height) : (y += 1) {
            var x: usize = 0;
            while (x < self.back.width) : (x += 1) {
                const back_cell = self.back.cells[y * self.back.width + x];
                const front_cell = self.front.cells[y * self.front.width + x];

                if (!back_cell.eql(front_cell)) {
                    // Jump cursor if not immediately following
                    if (cursor_y != y or cursor_x != x) {
                        printStdout("\x1b[{d};{d}H", .{ y + 1, x + 1 });
                        cursor_y = y;
                        cursor_x = x;
                    }

                    // Apply attributes if changed
                    if (back_cell.attr != last_attr or back_cell.fg != last_fg) {
                        printStdout("\x1b[0;{d}m", .{@intFromEnum(back_cell.fg)});
                        last_fg = back_cell.fg;
                        last_attr = back_cell.attr;
                    }

                    // Emit character
                    if (back_cell.codepoint <= 127) {
                        const ch = [_]u8{@as(u8, @intCast(back_cell.codepoint))};
                        writeStdout(&ch);
                    } else {
                        writeStdout("?");
                    }
                    cursor_x += 1;

                    // Update front buffer cell to match back
                    self.front.cells[y * self.front.width + x] = back_cell;
                }
            }
        }
    }

    /// Render standard layout: Header (20%), Interactive PTY (55%), Telemetry/AST Lens (25%)
    pub fn renderFrame(
        self: *Renderer,
        mission_title: []const u8,
        command_preview: []const u8,
        ast_summary: []const u8,
        invariant_status: []const u8,
    ) !void {
        self.back.clear();
        const w = self.back.width;
        const h = self.back.height;

        // Draw Header Border & Title
        self.back.writeString(2, 0, "⚡ CLITUTOR : ZERO-OVERHEAD ENGINE", .bright_cyan, buffer.Attr.bold);
        self.back.writeString(w - 20, 0, "[SANDBOX ACTIVE]", .bright_green, buffer.Attr.bold);

        // Header Section (Rows 1-3)
        self.back.writeString(2, 2, "MISSION:", .yellow, buffer.Attr.bold);
        self.back.writeString(11, 2, mission_title, .white, 0);

        self.back.writeString(2, 3, "COMMAND:", .cyan, buffer.Attr.bold);
        self.back.writeString(11, 3, command_preview, .bright_white, buffer.Attr.bold);

        // Horizontal Separator 1
        var x: usize = 0;
        while (x < w) : (x += 1) {
            self.back.set(x, 4, Cell{ .codepoint = '─', .fg = .bright_black });
        }

        // PTY Terminal Region label
        self.back.writeString(2, 5, "─── SUB-SHELL TERMINAL PTY ───", .bright_black, 0);

        // Horizontal Separator 2 (Lower 25%)
        const telemetry_y = h - (h / 4);
        x = 0;
        while (x < w) : (x += 1) {
            self.back.set(x, telemetry_y, Cell{ .codepoint = '─', .fg = .bright_black });
        }

        // Telemetry / AST Lens Pane
        self.back.writeString(2, telemetry_y + 1, "AST / KERNEL INVARIANT TELEMETRY", .bright_magenta, buffer.Attr.bold);
        self.back.writeString(2, telemetry_y + 2, "Flags AST:", .yellow, 0);
        self.back.writeString(13, telemetry_y + 2, ast_summary, .white, 0);

        self.back.writeString(2, telemetry_y + 3, "Invariants:", .yellow, 0);
        self.back.writeString(15, telemetry_y + 3, invariant_status, .bright_green, buffer.Attr.bold);

        try self.flush();
    }
};
