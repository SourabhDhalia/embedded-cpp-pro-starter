#include <gtest/gtest.h>

#include <memory>

#include "hal/gpio.hpp"

TEST(GPIO, HostStubToggles) {
  std::unique_ptr<hal::GPIO> gpio(hal::make_gpio(0, 1, hal::GPIOMode::Output));
  gpio->write(true);
  EXPECT_TRUE(gpio->read());
  gpio->write(false);
  EXPECT_FALSE(gpio->read());
}
