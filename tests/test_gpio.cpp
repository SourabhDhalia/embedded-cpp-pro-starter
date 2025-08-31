#include <gtest/gtest.h>
#include "hal/gpio.hpp"
TEST(GPIO, HostStubToggles) {
  std::unique_ptr<hal::GPIO> g(hal::make_gpio(0, 1, hal::GPIOMode::Output));
  g->write(true);
  EXPECT_TRUE(g->read());
  g->write(false);
  EXPECT_FALSE(g->read());
}

