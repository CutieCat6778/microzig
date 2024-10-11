const std = @import("std");
const MicroZig = @import("microzig/build");
const rp2xxx = @import("microzig/port/raspberrypi/rp2xxx");

pub fn build(b: *std.Build) void {
    const mz = MicroZig.init(b, .{});
    const optimize = b.standardOptimizeOption(.{});

    const firmware = mz.add_firmware(b, .{
        .name = "blink",
        .target = rp2xxx.boards.raspberrypi.pico,
        .optimize = optimize,
        .root_source_file = b.path("src/main.zig"),
    });

    mz.install_firmware(b, firmware, .{});

    mz.install_firmware(b, firmware, .{ .format = .elf });
}
