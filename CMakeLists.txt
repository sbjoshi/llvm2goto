cmake_minimum_required(VERSION 3.10)


project(LLVM2GOTO)

file(GLOB ll2gb_SRC "src/*.cpp")

set(CBMC_DIR ${HOME}/work/cbmc)
set(CBMC_SRC ${CBMC_DIR}/src)


execute_process(COMMAND llvm-config --includedir OUTPUT_VARIABLE LLVM_INCLUDES OUTPUT_STRIP_TRAILING_WHITESPACE)
execute_process(COMMAND llvm-config --libdir OUTPUT_VARIABLE LLVM_LIBS OUTPUT_STRIP_TRAILING_WHITESPACE)

include(ExternalProject)
find_program(MAKE_EXE NAMES make)
ExternalProject_Add(cbmc 
	SOURCE_DIR 	${CBMC_SRC} 
	CONFIGURE_COMMAND	${MAKE_EXE} -C ${CBMC_SRC} minisat2-download
	BUILD_COMMAND		${MAKE_EXE} -C ${CBMC_SRC}
	BUILD_IN_SOURCE		True
)


add_executable(ll2gb ${ll2gb_SRC} ${CBMC_OBJS})
add_dependencies(ll2gb cbmc)


include_directories(${CMAKE_SOURCE_DIR} ${CBMC_SRC} ${LLVM_INCLUDES})
link_directories(${LLVM_LIBS} ${CBMC_SRC})


if(CMAKE_CXX_COMPILER_ID STREQUAL "Clang" OR CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
	set(CXXFLAGS "${CXXFLAGS} -Wall -Wextra -std=c++03")
endif()

set(CBMC_OBJS 
${CBMC_SRC}/cbmc/cbmc_parse_options.o 
${CBMC_SRC}/cbmc/c_test_input_generator.o 
${CBMC_SRC}/goto-symex/show_vcc.o 
${CBMC_SRC}/goto-checker/goto-checker.a 
${CBMC_SRC}/solvers/solvers.a 
${CBMC_SRC}/goto-instrument/unwindset.o 
${CBMC_SRC}/cbmc/cbmc_languages.o 
${CBMC_SRC}/statement-list/statement-list.a 
${CBMC_SRC}/cpp/cpp.a 
${CBMC_SRC}/json-symtab-language/json_symtab_language.o 
${CBMC_SRC}/json-symtab-language/json_symbol_table.o 
${CBMC_SRC}/json-symtab-language/json_symbol.o 
${CBMC_SRC}/ansi-c/ansi-c.a 
${CBMC_SRC}/linking/linking.a 
${CBMC_SRC}/json/json.a 
${CBMC_SRC}/goto-symex/goto-symex.a 
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
${CBMC_SRC}/goto-programs/goto-programs.a 
${CBMC_SRC}/langapi/langapi.a 
${CBMC_SRC}/xmllang/xmllang.a 
${CBMC_SRC}/assembler/assembler.a 
${CBMC_SRC}/pointer-analysis/value_set_fi.o 
${CBMC_SRC}/analyses/analyses.a 
${CBMC_SRC}/pointer-analysis/goto_program_dereference.o 
${CBMC_SRC}/pointer-analysis/value_set_dereference.o 
${CBMC_SRC}/util/util.a -l:jbmc/src/java_bytecode/java_bytecode.a 
${CBMC_SRC}/big-int/big-int.a 
${CBMC_SRC}/jsil/jsil.a
)

