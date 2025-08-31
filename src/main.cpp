// SPDX-License-Identifier: Apache-2.0
#include <memory>

#include "core/log.hpp"
#include "core/version.hpp"
#include "hal/gpio.hpp"
int main() {
  auto& log = core::default_logger();
  log.info(std::string("embedded-cpp-pro-starter v") + core::version());
  std::unique_ptr<hal::GPIO> led(hal::make_gpio(0, 13, hal::GPIOMode::Output));
  led->write(true);
  log.info("LED set HIGH (host stub)");
  return 0;
}
