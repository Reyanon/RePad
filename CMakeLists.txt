cmake_minimum_required(VERSION 3.16)

if(NOT DEFINED CMAKE_TOOLCHAIN_FILE)
  if(DEFINED ENV{VITASDK})
    set(CMAKE_TOOLCHAIN_FILE "$ENV{VITASDK}/share/vita.toolchain.cmake" CACHE PATH "toolchain file")
  else()
    message(FATAL_ERROR "Please define VITASDK to point to your SDK path")
  endif()
endif()

project(repad C)
include("${VITASDK}/share/vita.cmake" REQUIRED)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O2 -Wall -Wextra -Wno-unused-parameter -std=gnu11 -fno-builtin")

add_executable(repad
  src/main.c
  src/bt.c
  src/ctrl.c
  src/pads.c
)

target_link_libraries(repad
  SceBtForDriver_stub
  SceCtrlForDriver_stub
  SceKernelSuspendForDriver_stub
  SceSblAIMgrForDriver_stub
  SceSysclibForDriver_stub
  SceThreadmgrForDriver_stub
  taihenForKernel_stub
  taihenModuleUtils_stub
)

set_target_properties(repad PROPERTIES LINK_FLAGS "-nostdlib")

# (vita_create_self splits its flags on spaces: the module config path cannot go through it when the tree's path has one)
add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/repad.skprx"
  COMMAND vita-elf-create -e "${CMAKE_SOURCE_DIR}/repad.yml" $<TARGET_FILE:repad> "${CMAKE_BINARY_DIR}/repad.velf"
  COMMAND vita-make-fself -c "${CMAKE_BINARY_DIR}/repad.velf" "${CMAKE_BINARY_DIR}/repad.skprx"
  DEPENDS repad "${CMAKE_SOURCE_DIR}/repad.yml"
  VERBATIM)
add_custom_target(repad_skprx ALL DEPENDS "${CMAKE_BINARY_DIR}/repad.skprx")
