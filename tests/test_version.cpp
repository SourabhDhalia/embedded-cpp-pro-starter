#include <gtest/gtest.h>
#include "core/version.hpp"
TEST(Version, StringPresent) {
  ASSERT_STRNE(core::version(), "");
}

