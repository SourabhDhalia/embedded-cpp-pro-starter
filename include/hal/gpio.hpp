// SPDX-License-Identifier: Apache-2.0
#pragma once
#include <cstdint>

namespace hal {

enum class GPIOMode { Input, Output };

class GPIO {
 public:
  virtual ~GPIO() = default;
  virtual void write(bool high) = 0;
  virtual bool read() const = 0;
};

// Factory for platform-specific GPIO; on host returns a stub.
GPIO* make_gpio(int port, int pin, GPIOMode mode);

}

