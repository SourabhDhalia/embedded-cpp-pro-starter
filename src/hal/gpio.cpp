// SPDX-License-Identifier: Apache-2.0
#include "hal/gpio.hpp"
// Host stub implementation; replace with MCU HAL when cross-compiling.
namespace hal {
namespace { class StubGPIO : public GPIO { bool level_ = false; public: void write(bool h) override { level_ = h; } bool read() const override { return level_; } }; }
GPIO* make_gpio(int, int, GPIOMode) { return new StubGPIO(); }
}

