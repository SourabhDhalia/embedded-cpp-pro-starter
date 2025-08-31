// SPDX-License-Identifier: Apache-2.0
#include "hal/gpio.hpp"

// Host stub implementation; replace with MCU HAL when cross-compiling.
namespace hal {

namespace {

class StubGPIO : public GPIO {
 public:
  auto write(bool high) -> void override { level_ = high; }
  [[nodiscard]] auto read() const -> bool override { return level_; }

 private:
  bool level_ = false;
};

}  // namespace

auto make_gpio(int /*port*/, int /*pin*/, GPIOMode /*mode*/) -> GPIO* { return new StubGPIO(); }

}  // namespace hal
