// SPDX-License-Identifier: Apache-2.0
#include "core/log.hpp"

#include <iostream>

namespace {

class StdoutLogger : public core::Logger {
 public:
  void info(const std::string& msg) override { std::cout << "[INFO] " << msg << "\n"; }
  void error(const std::string& msg) override { std::cerr << "[ERR ] " << msg << "\n"; }
};

struct LoggerState {
  StdoutLogger fallback;
  core::Logger* current = &fallback;
};

auto state() -> LoggerState& {
  static LoggerState logger_state;
  return logger_state;
}

}  // namespace

namespace core {

auto default_logger() -> Logger& { return *state().current; }

auto set_default_logger(Logger* logger) -> void {
  auto& logger_state = state();
  logger_state.current = (logger != nullptr) ? logger : &logger_state.fallback;
}

}  // namespace core
