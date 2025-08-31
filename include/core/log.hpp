// SPDX-License-Identifier: Apache-2.0
#pragma once
#include <cstdint>
#include <string>

namespace core {

class Logger {
 public:
  virtual ~Logger() = default;
  virtual void info(const std::string& msg) = 0;
  virtual void error(const std::string& msg) = 0;
};

auto default_logger() -> Logger&;
auto set_default_logger(Logger* logger) -> void;

}  // namespace core
