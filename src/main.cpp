// SPDX-License-Identifier: Apache-2.0
#include <memory>

#include "core/log.hpp"
#include "core/version.hpp"
#include "hal/gpio.hpp"
auto main() -> int {
  constexpr int kLedPort = 0;
  constexpr int kLedPin = 13;

  auto& log = core::default_logger();
  log.info(std::string("embedded-cpp-pro-starter v") + core::version());
  std::unique_ptr<hal::GPIO> led(hal::make_gpio(kLedPort, kLedPin, hal::GPIOMode::Output));
  led->write(true);
  log.info("LED set HIGH (host stub)");
  return 0;
}
