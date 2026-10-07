pub const cow = @import("cow.zig");
pub const pty = @import("pty.zig");
pub const dict = @import("syntax/dict.zig");
pub const lexer = @import("syntax/lexer.zig");
pub const verify = @import("verify.zig");
pub const buffer = @import("ui/buffer.zig");
pub const renderer = @import("ui/renderer.zig");

test {
    _ = cow;
    _ = pty;
    _ = dict;
    _ = lexer;
    _ = verify;
    _ = buffer;
    _ = renderer;
}
