// SPDX-License-Identifier: Apache-2.0
#include "core/log.hpp"

#include <iostream>
namespace {
class StdoutLogger : public core::Logger {
 public:
  void info(const std::string& msg) override { std::cout << "[INFO] " << msg << "\n"; }
  void error(const std::string& msg) override { std::cerr << "[ERR ] " << msg << "\n"; }
};
StdoutLogger g_logger;
}  // namespace
namespace core {
static Logger* current = &g_logger;
Logger& default_logger() { return *current; }
void set_default_logger(Logger* l) { current = l ? l : &g_logger; }
}  // namespace core
