cmake_minimum_required(VERSION 3.20)
project(embedded_cpp_pro_starter VERSION 0.1.0 LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

option(BUILD_TESTS "Build unit tests" ON)
option(ENABLE_SANITIZERS "Enable ASan/UBSan (host only)" ON)
option(ENABLE_COVERAGE "Enable GCC coverage (host only)" OFF)
option(ENABLE_CLANG_TIDY "Enable clang-tidy via CMake" OFF)

if(ENABLE_CLANG_TIDY)
  find_program(CLANG_TIDY_EXE NAMES clang-tidy)
  if(CLANG_TIDY_EXE)
    set(CMAKE_CXX_CLANG_TIDY "${CLANG_TIDY_EXE}")
  endif()
endif()

if(ENABLE_SANITIZERS AND NOT CMAKE_TOOLCHAIN_FILE)
  add_compile_options(-fsanitize=address,undefined -fno-omit-frame-pointer)
  add_link_options(-fsanitize=address,undefined)
endif()

if(ENABLE_COVERAGE AND CMAKE_CXX_COMPILER_ID STREQUAL "GNU" AND NOT CMAKE_TOOLCHAIN_FILE)
  add_compile_options(--coverage)
  add_link_options(--coverage)
endif()

include(GNUInstallDirs)

add_library(core
  src/core/log.cpp
  src/hal/gpio.cpp
)

target_include_directories(core PUBLIC ${PROJECT_SOURCE_DIR}/include)

add_executable(host_app src/main.cpp)
target_link_libraries(host_app PRIVATE core)

# Firmware target (no syscalls here; link with your BSP later)
add_executable(firmware src/firmware/main_firmware.cpp)
target_link_libraries(firmware PRIVATE core)

# Installable headers + libs (optional)
install(TARGETS core
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})
install(DIRECTORY include/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

# Testing
if(BUILD_TESTS AND NOT CMAKE_TOOLCHAIN_FILE)
  include(FetchContent)
  set(BUILD_GMOCK OFF CACHE BOOL "" FORCE)
  set(INSTALL_GTEST OFF CACHE BOOL "" FORCE)
  FetchContent_Declare(
    googletest
    URL https://github.com/google/googletest/archive/refs/tags/v1.14.0.zip
  )
  FetchContent_MakeAvailable(googletest)

  enable_testing()
  add_executable(unit_tests
    tests/test_gpio.cpp
    tests/test_version.cpp
  )
  target_link_libraries(unit_tests PRIVATE core GTest::gtest_main)
  include(GoogleTest)
  gtest_discover_tests(unit_tests)
endif()

