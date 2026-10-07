const std = @import("std");

pub const Color = enum(u8) {
    default = 0,
    black = 30,
    red = 31,
    green = 32,
    yellow = 33,
    blue = 34,
    magenta = 35,
    cyan = 36,
    white = 37,
    bright_black = 90,
    bright_red = 91,
    bright_green = 92,
    bright_yellow = 93,
    bright_blue = 94,
    bright_magenta = 95,
    bright_cyan = 96,
    bright_white = 97,
};

pub const Attr = struct {
    pub const bold: u8 = 1 << 0;
    pub const dim: u8 = 1 << 1;
    pub const italic: u8 = 1 << 2;
    pub const underline: u8 = 1 << 3;
};

pub const Cell = struct {
    codepoint: u21 = ' ',
    fg: Color = .default,
    bg: Color = .default,
    attr: u8 = 0,

    pub fn eql(self: Cell, other: Cell) bool {
        return self.codepoint == other.codepoint and
            self.fg == other.fg and
            self.bg == other.bg and
            self.attr == other.attr;
    }
};

/// High-performance flat 1D double-buffered grid for 120 FPS differential rendering
pub const Grid = struct {
    width: usize,
    height: usize,
    cells: []Cell,
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator, width: usize, height: usize) !Grid {
        const total = width * height;
        const cells = try allocator.alloc(Cell, total);
        @memset(cells, Cell{});
        return Grid{
            .width = width,
            .height = height,
            .cells = cells,
            .allocator = allocator,
        };
    }

    pub fn deinit(self: *Grid) void {
        self.allocator.free(self.cells);
    }

    pub fn clear(self: *Grid) void {
        @memset(self.cells, Cell{});
    }

    pub fn set(self: *Grid, x: usize, y: usize, cell: Cell) void {
        if (x < self.width and y < self.height) {
            self.cells[y * self.width + x] = cell;
        }
    }

    pub fn writeString(self: *Grid, start_x: usize, y: usize, text: []const u8, fg: Color, attr: u8) void {
        if (y >= self.height) return;
        var cur_x = start_x;
        for (text) |ch| {
            if (cur_x >= self.width) break;
            self.set(cur_x, y, Cell{
                .codepoint = ch,
                .fg = fg,
                .attr = attr,
            });
            cur_x += 1;
        }
    }
};
