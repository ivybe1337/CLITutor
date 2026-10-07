const std = @import("std");

pub const FlagInfo = struct {
    short: ?u8,
    long: []const u8,
    description: []const u8,
    is_dangerous: bool = false,
    warning: ?[]const u8 = null,
};

pub const ToolDefinition = struct {
    name: []const u8,
    summary: []const u8,
    flags: []const FlagInfo,
};

// Compile-Time static tables embedded directly into .rodata with zero runtime allocations
pub const TOOLS = [_]ToolDefinition{
    .{
        .name = "tar",
        .summary = "Tape archive utility for creating and extracting compressed archives",
        .flags = &.{
            .{ .short = 'c', .long = "create", .description = "Create a new archive" },
            .{ .short = 'x', .long = "extract", .description = "Extract files from an archive" },
            .{ .short = 'v', .long = "verbose", .description = "Verbosely list files processed" },
            .{ .short = 'f', .long = "file", .description = "Use archive file or device ARCHIVE" },
            .{ .short = 'z', .long = "gzip", .description = "Filter the archive through gzip" },
            .{ .short = 'j', .long = "bzip2", .description = "Filter the archive through bzip2" },
            .{ .short = 'J', .long = "xz", .description = "Filter the archive through xz" },
        },
    },
    .{
        .name = "find",
        .summary = "Search for files in a directory hierarchy",
        .flags = &.{
            .{ .short = null, .long = "name", .description = "Base of file name matches shell pattern" },
            .{ .short = null, .long = "type", .description = "File is of type (d=dir, f=file, l=symlink)" },
            .{ .short = null, .long = "mtime", .description = "File's data was modified N*24 hours ago" },
            .{ .short = null, .long = "exec", .description = "Execute command on matching files", .is_dangerous = true, .warning = "Unquoted arguments can trigger unintended code execution" },
            .{ .short = null, .long = "delete", .description = "Delete matched files directly", .is_dangerous = true, .warning = "Deletes matched files permanently without prompt!" },
        },
    },
    .{
        .name = "grep",
        .summary = "Print lines that match patterns",
        .flags = &.{
            .{ .short = 'i', .long = "ignore-case", .description = "Ignore case distinctions in patterns and data" },
            .{ .short = 'r', .long = "recursive", .description = "Read all files under each directory recursively" },
            .{ .short = 'v', .long = "invert-match", .description = "Select non-matching lines" },
            .{ .short = 'n', .long = "line-number", .description = "Prefix each line of output with its line number" },
            .{ .short = 'l', .long = "files-with-matches", .description = "Suppress normal output; print name of each input file with matches" },
            .{ .short = 'E', .long = "extended-regexp", .description = "Interpret PATTERNS as extended regular expressions" },
        },
    },
    .{
        .name = "chmod",
        .summary = "Change file mode bits (permissions)",
        .flags = &.{
            .{ .short = 'R', .long = "recursive", .description = "Change files and directories recursively", .is_dangerous = true, .warning = "Can make system files non-executable or globally writable" },
            .{ .short = 'v', .long = "verbose", .description = "Output a diagnostic for every file processed" },
        },
    },
    .{
        .name = "rsync",
        .summary = "Fast, versatile, remote and local file-copying tool",
        .flags = &.{
            .{ .short = 'a', .long = "archive", .description = "Archive mode (equals -rlptgoD, preserves all metadata)" },
            .{ .short = 'v', .long = "verbose", .description = "Increase verbosity" },
            .{ .short = 'z', .long = "compress", .description = "Compress file data during transfer" },
            .{ .short = 'P', .long = "partial-progress", .description = "Show progress bar and keep partially transferred files" },
            .{ .short = null, .long = "delete", .description = "Delete extraneous files from destination dirs", .is_dangerous = true, .warning = "Destructive! Files missing on source will be deleted on destination!" },
        },
    },
    .{
        .name = "git",
        .summary = "Fast, scalable, distributed revision control system",
        .flags = &.{
            .{ .short = 'm', .long = "message", .description = "Use the given message as the commit message" },
            .{ .short = 'b', .long = "branch", .description = "Create and checkout a new branch" },
            .{ .short = 'a', .long = "all", .description = "Stage all modified and deleted files" },
            .{ .short = 'f', .long = "force", .description = "Force overwrite of remote branch or checkout", .is_dangerous = true, .warning = "Overwrites history on the remote branch, potentially destroying team commits!" },
        },
    },
};

pub fn findTool(name: []const u8) ?ToolDefinition {
    inline for (TOOLS) |tool| {
        if (std.mem.eql(u8, tool.name, name)) {
            return tool;
        }
    }
    return null;
}

pub fn findFlag(tool: ToolDefinition, flag_arg: []const u8) ?FlagInfo {
    if (std.mem.startsWith(u8, flag_arg, "--")) {
        const long_name = flag_arg[2..];
        for (tool.flags) |f| {
            if (std.mem.eql(u8, f.long, long_name)) return f;
        }
    } else if (std.mem.startsWith(u8, flag_arg, "-") and flag_arg.len == 2) {
        const short_char = flag_arg[1];
        for (tool.flags) |f| {
            if (f.short == short_char) return f;
        }
    }
    return null;
}
