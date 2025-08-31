// SPDX-License-Identifier: Apache-2.0
#include "hal/gpio.hpp"
extern "C" int main(void) {
  hal::GPIO* led = hal::make_gpio(0, 13, hal::GPIOMode::Output);
  // Simple firmware loop (replace with RTOS/tasking)
  for (;;) {
    led->write(true);
    // delay stub
    led->write(false);
  }
  return 0;
}
