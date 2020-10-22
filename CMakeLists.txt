cmake_minimum_required(VERSION 3.10)


project(LLVM2GOTO)

file(GLOB LL2GB_SRC "src/*.cpp")

if(NOT DEFINED CBMC_DIR)
	message(FATAL_ERROR "Speicify CBMC directory using -DCBMC_DIR=<your_path>/cbmc")
endif(NOT DEFINED CBMC_DIR)

set(CBMC_SRC ${CBMC_DIR}/src)

if(NOT DEFINED LLVM_CONFIG)
	set(LLVM_CONFIG "llvm-config")
endif(NOT DEFINED LLVM_CONFIG)

message("-- Using CBMC_DIR = '${CBMC_DIR}'")
message("-- Using LLVM_CONFIG = '${LLVM_CONFIG}'")

execute_process(COMMAND ${LLVM_CONFIG} --includedir OUTPUT_VARIABLE LLVM_INCLUDES OUTPUT_STRIP_TRAILING_WHITESPACE)
execute_process(COMMAND ${LLVM_CONFIG} --libs irreader passes OUTPUT_VARIABLE LLVM_LIBS OUTPUT_STRIP_TRAILING_WHITESPACE)
execute_process(COMMAND ${LLVM_CONFIG} --system-libs OUTPUT_VARIABLE LLVM_SYS_LIBS OUTPUT_STRIP_TRAILING_WHITESPACE)
execute_process(COMMAND ${LLVM_CONFIG} --libdir OUTPUT_VARIABLE LLVM_LIBDIR OUTPUT_STRIP_TRAILING_WHITESPACE)
execute_process(COMMAND ${LLVM_CONFIG} --cxxflags OUTPUT_VARIABLE LLVM_CXXFLAGS OUTPUT_STRIP_TRAILING_WHITESPACE)

include_directories(${CMAKE_SOURCE_DIR} ${CBMC_SRC} ${LLVM_INCLUDES})
link_directories(${LLVM_LIBDIR} ${CBMC_SRC})

set(CMAKE_CXX_FLAGS "${LLVM_CXXFLAGS} -Werror -Wno-init-list-lifetime -Wno-deprecated-declarations -Wno-unused-parameter -Wno-deprecated-copy -fexceptions")

if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra")
endif()

if(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Weverything")
endif()

list(APPEND CBMC_STATIC_LIBS
${CBMC_SRC}/goto-checker/goto-checker.a
${CBMC_SRC}/solvers/solvers.a
${CBMC_SRC}/statement-list/statement-list.a
${CBMC_SRC}/cpp/cpp.a
${CBMC_SRC}/ansi-c/ansi-c.a
${CBMC_SRC}/linking/linking.a
${CBMC_SRC}/json/json.a
${CBMC_SRC}/goto-symex/goto-symex.a
${CBMC_SRC}/goto-programs/goto-programs.a
${CBMC_SRC}/langapi/langapi.a
${CBMC_SRC}/xmllang/xmllang.a
${CBMC_SRC}/assembler/assembler.a
${CBMC_SRC}/analyses/analyses.a
${CBMC_SRC}/util/util.a
${CBMC_DIR}/jbmc/src/java_bytecode/java_bytecode.a
${CBMC_SRC}/big-int/big-int.a
${CBMC_SRC}/jsil/jsil.a
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
)

set(THREADS_PREFER_PTHREAD_FLAG ON)
find_package(Threads REQUIRED)

add_executable(ll2gb ${LL2GB_SRC} ${CBMC_OBJS})
target_link_libraries(ll2gb ${CBMC_STATIC_LIBS} ${LLVM_LIBS} ${LLVM_SYS_LIBS})
