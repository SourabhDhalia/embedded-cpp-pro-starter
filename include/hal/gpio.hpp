// SPDX-License-Identifier: Apache-2.0
#pragma once
#include <cstdint>

namespace hal {

enum class GPIOMode { Input, Output };

class GPIO {
 public:
  virtual ~GPIO() = default;
  virtual auto write(bool high) -> void = 0;
  [[nodiscard]] virtual auto read() const -> bool = 0;
};

// Factory for platform-specific GPIO; on host returns a stub.
auto make_gpio(int port, int pin, GPIOMode mode) -> GPIO*;

}  // namespace hal
