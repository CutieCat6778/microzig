const std = @import("std");
const microzig = @import("microzig");
const stm32 = microzig.hal;

const LED_PIN = stm32.parse_pin("PE8");

pub fn main() !void {
    stm32.gpio.set_output(LED_PIN);

    while (true) {
        stm32.gpio.write(LED_PIN, .high);
        delay_ms(1000);

        stm32.gpio.write(LED_PIN, .low);
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
