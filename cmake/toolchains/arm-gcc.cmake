set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)
set(ARM_NONE_EABI arm-none-eabi)
set(CMAKE_C_COMPILER ${ARM_NONE_EABI}-gcc)
set(CMAKE_CXX_COMPILER ${ARM_NONE_EABI}-g++)
set(CMAKE_ASM_COMPILER ${ARM_NONE_EABI}-gcc)
set(CMAKE_AR ${ARM_NONE_EABI}-ar)
set(CMAKE_OBJCOPY ${ARM_NONE_EABI}-objcopy)
set(CMAKE_OBJDUMP ${ARM_NONE_EABI}-objdump)
set(CMAKE_SIZE ${ARM_NONE_EABI}-size)

# Tune to your MCU
set(MCU_FLAGS "-mcpu=cortex-m4 -mthumb -mfpu=fpv4-sp-d16 -mfloat-abi=hard")
set(OPT_FLAGS "-O2 -ffunction-sections -fdata-sections -fno-exceptions -fno-rtti -fno-unwind-tables -fno-asynchronous-unwind-tables")
set(LINK_FLAGS "-Wl,--gc-sections")

set(CMAKE_C_FLAGS "${MCU_FLAGS} ${OPT_FLAGS} -std=c11" CACHE STRING "" FORCE)
set(CMAKE_CXX_FLAGS "${MCU_FLAGS} ${OPT_FLAGS} -std=c++17" CACHE STRING "" FORCE)
set(CMAKE_EXE_LINKER_FLAGS "${MCU_FLAGS} ${LINK_FLAGS}" CACHE STRING "" FORCE)

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

