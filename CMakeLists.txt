cmake_minimum_required(VERSION 3.10)


project(LLVM2GOTO)

file(GLOB LL2GB_SRC "src/*.cpp")

if(NOT DEFINED CBMC_DIR)
	message(FATAL_ERROR "Speicify CBMC directory using -DCBMC_DIR=<your_path>/cbmc")
endif()

set(CBMC_SRC ${CBMC_DIR}/src)

if(NOT DEFINED LLVM_CONFIG)
	set(LLVM_CONFIG "llvm-config")
endif()

if(CMAKE_BUILD_TYPE STREQUAL "")
	set(CMAKE_BUILD_TYPE Release)
endif()

message("-- Build Type: ${CMAKE_BUILD_TYPE}")
message("-- Using CBMC_DIR = '${CBMC_DIR}'")
message("-- Using LLVM_CONFIG = '${LLVM_CONFIG}'")

execute_process(COMMAND ${LLVM_CONFIG} --includedir OUTPUT_VARIABLE LLVM_INCLUDES OUTPUT_STRIP_TRAILING_WHITESPACE)
execute_process(COMMAND ${LLVM_CONFIG} --libs irreader passes OUTPUT_VARIABLE LLVM_LIBS OUTPUT_STRIP_TRAILING_WHITESPACE)
execute_process(COMMAND ${LLVM_CONFIG} --system-libs OUTPUT_VARIABLE LLVM_SYS_LIBS OUTPUT_STRIP_TRAILING_WHITESPACE)
execute_process(COMMAND ${LLVM_CONFIG} --libdir OUTPUT_VARIABLE LLVM_LIBDIR OUTPUT_STRIP_TRAILING_WHITESPACE)
execute_process(COMMAND ${LLVM_CONFIG} --cxxflags OUTPUT_VARIABLE LLVM_CXXFLAGS OUTPUT_STRIP_TRAILING_WHITESPACE)
execute_process(COMMAND ${LLVM_CONFIG} --version OUTPUT_VARIABLE LLVM_VERSION OUTPUT_STRIP_TRAILING_WHITESPACE)

message("-- LLVM Version: ${LLVM_VERSION}")
if(${LLVM_VERSION} VERSION_LESS "10.0")
	message(FATAL_ERROR "LLVM Version 10.x or above required")
endif()

include_directories(${CMAKE_SOURCE_DIR} ${CBMC_SRC} ${LLVM_INCLUDES})
link_directories(${LLVM_LIBDIR} ${CBMC_SRC})

set(CMAKE_CXX_FLAGS "${LLVM_CXXFLAGS} -Werror -Wall -Wextra -Wno-deprecated-declarations -Wno-unused-parameter -fexceptions")

if(CMAKE_BUILD_TYPE STREQUAL Debug)
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g")
else()
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O2")
endif()

if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-deprecated-copy")
endif()

if(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-deprecated")
endif()

list(APPEND CBMC_STATIC_LIB_DIRS
${CBMC_SRC}/goto-checker
${CBMC_SRC}/solvers
${CBMC_SRC}/statement-list
${CBMC_SRC}/cpp
${CBMC_SRC}/ansi-c
${CBMC_SRC}/linking
${CBMC_SRC}/json
${CBMC_SRC}/goto-symex
${CBMC_SRC}/goto-programs
${CBMC_SRC}/langapi
${CBMC_SRC}/xmllang
${CBMC_SRC}/assembler
${CBMC_SRC}/analyses
${CBMC_SRC}/util
${CBMC_DIR}/jbmc/src/java_bytecode
${CBMC_SRC}/big-int
${CBMC_SRC}/jsil
)
link_directories(${CBMC_STATIC_LIB_DIRS})

list(APPEND CBMC_STATIC_LIBS
:goto-checker.a
:solvers.a
:statement-list.a
:cpp.a
:ansi-c.a
:linking.a
:json.a
:goto-symex.a
:goto-programs.a
:langapi.a
:xmllang.a
:assembler.a
:analyses.a
:util.a
:java_bytecode.a
:big-int.a
:jsil.a
)



set(CBMC_OBJS
${CBMC_SRC}/cbmc/cbmc_parse_options.o
${CBMC_SRC}/cbmc/c_test_input_generator.o
${CBMC_SRC}/goto-symex/show_vcc.o
${CBMC_SRC}/goto-instrument/unwindset.o
${CBMC_SRC}/cbmc/cbmc_languages.o
${CBMC_SRC}/json-symtab-language/json_symtab_language.o
${CBMC_SRC}/json-symtab-language/json_symbol_table.o
${CBMC_SRC}/json-symtab-language/json_symbol.o
${CBMC_SRC}/pointer-analysis/value_set.o
${CBMC_SRC}/pointer-analysis/add_failed_symbols.o
${CBMC_SRC}/goto-instrument/cover.o
${CBMC_SRC}/goto-instrument/nondet_static.o
${CBMC_SRC}/goto-instrument/full_slicer.o
${CBMC_SRC}/goto-instrument/reachability_slicer.o
${CBMC_SRC}/goto-instrument/cover_filter.o
${CBMC_SRC}/goto-instrument/cover_util.o
${CBMC_SRC}/goto-instrument/cover_instrument_assume.o
${CBMC_SRC}/goto-instrument/cover_instrument_condition.o
${CBMC_SRC}/goto-instrument/cover_instrument_decision.o
${CBMC_SRC}/goto-instrument/cover_instrument_location.o
${CBMC_SRC}/goto-instrument/cover_instrument_branch.o
${CBMC_SRC}/goto-instrument/cover_instrument_mcdc.o
${CBMC_SRC}/goto-instrument/cover_instrument_other.o
${CBMC_SRC}/goto-instrument/cover_basic_blocks.o
${CBMC_SRC}/goto-instrument/source_lines.o
${CBMC_SRC}/pointer-analysis/value_set_analysis_fi.o
${CBMC_SRC}/pointer-analysis/value_set_domain_fi.o
${CBMC_SRC}/pointer-analysis/value_set_fi.o
${CBMC_SRC}/pointer-analysis/goto_program_dereference.o
${CBMC_SRC}/pointer-analysis/value_set_dereference.o
${CBMC_SRC}/ansi-c/goto_check_c.o
)

set(THREADS_PREFER_PTHREAD_FLAG ON)
find_package(Threads REQUIRED)

add_executable(ll2gb ${LL2GB_SRC} ${CBMC_OBJS})
target_link_libraries(ll2gb ${CBMC_STATIC_LIBS} ${LLVM_LIBS} ${LLVM_SYS_LIBS})
