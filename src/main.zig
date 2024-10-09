const std = @import("std");
const microzig = @import("microzig");
const hal = microzig.hal;

const LED_PIN = hal.parse_pin("PE8");

pub fn main() !void {
    hal.gpio.set_output(LED_PIN);

    while (true) {
        hal.gpio.write(LED_PIN, .high);
        delay_ms(1000);

        microzig.gpio.write(LED_PIN, .low);
        delay_ms(1000);
    }
}

fn delay_ms(ms: u32) void {
    var i: u32 = 0;
    const cycles_per_ms = 8000;
    while (i < ms * cycles_per_ms) : (i += 1) {
        asm volatile ("nop");
    }
}
