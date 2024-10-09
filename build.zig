const std = @import("std");
const MicroZig = @import("microzig/build");
const stm32 = @import("microzig/port/stmicro/stm32");

pub fn build(b: *std.Build) void {
    const microzig = MicroZig.init(b, .{});
    const optimize = b.standardOptimizeOption(.{});

    const firmware = microzig.add_firmware(b, .{
        .name = "stm32f3discovery",
        .target = stm32.boards.stm32f3discovery,
        .optimize = optimize,
        .root_source_file = b.path("src/main.zig"),
    });

    microzig.install_firmware(b, firmware, .{});
    microzig.install_firmware(b, firmware, .{ .format = .elf });
}
