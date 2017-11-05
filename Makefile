include config.inc

SRC = $(wildcard $(SOURCEDIR)/*.cpp)

OBJ +=$(CBMC_SRC_PATH)/ansi-c/ansi-c$(LIBEXT) \
      $(CBMC_SRC_PATH)/cpp/cpp$(LIBEXT) \
      $(CBMC_SRC_PATH)/linking/linking$(LIBEXT) \
      $(CBMC_SRC_PATH)/big-int/big-int$(LIBEXT) \
      $(CBMC_SRC_PATH)/goto-programs/goto-programs$(LIBEXT) \
      $(CBMC_SRC_PATH)/goto-symex/goto-symex$(LIBEXT) \
      $(CBMC_SRC_PATH)/pointer-analysis/value_set$(OBJEXT) \
      $(CBMC_SRC_PATH)/pointer-analysis/value_set_analysis_fi$(OBJEXT) \
      $(CBMC_SRC_PATH)/pointer-analysis/value_set_domain_fi$(OBJEXT) \
      $(CBMC_SRC_PATH)/pointer-analysis/value_set_fi$(OBJEXT) \
      $(CBMC_SRC_PATH)/pointer-analysis/value_set_dereference$(OBJEXT) \
      $(CBMC_SRC_PATH)/pointer-analysis/dereference_callback$(OBJEXT) \
      $(CBMC_SRC_PATH)/pointer-analysis/add_failed_symbols$(OBJEXT) \
      $(CBMC_SRC_PATH)/pointer-analysis/rewrite_index$(OBJEXT) \
      $(CBMC_SRC_PATH)/pointer-analysis/goto_program_dereference$(OBJEXT) \
      $(CBMC_SRC_PATH)/goto-cc/compile$(OBJEXT)\
      $(CBMC_SRC_PATH)/goto-instrument/full_slicer$(OBJEXT) \
      $(CBMC_SRC_PATH)/goto-instrument/nondet_static$(OBJEXT) \
      $(CBMC_SRC_PATH)/goto-instrument/cover$(OBJEXT) \
      $(CBMC_SRC_PATH)/analyses/analyses$(LIBEXT) \
      $(CBMC_SRC_PATH)/langapi/langapi$(LIBEXT) \
      $(CBMC_SRC_PATH)/xmllang/xmllang$(LIBEXT) \
      $(CBMC_SRC_PATH)/assembler/assembler$(LIBEXT) \
      $(CBMC_SRC_PATH)/solvers/solvers$(LIBEXT) \
      $(CBMC_SRC_PATH)/util/util$(LIBEXT) \
      $(CBMC_SRC_PATH)/miniz/miniz$(OBJEXT) \
      $(CBMC_SRC_PATH)/json/json$(LIBEXT)

INCLUDES= -I $(CBMC_SRC_PATH)

LIBS =

BUILD_ENV_ := Unix
LIBEXT = .a
OBJEXT = .o
EXEEXT =
CFLAGS ?= -Wall -O2
CXXFLAGS ?= -Wall -O2 -fno-rtti -O0 -g
CP_CFLAGS = -MMD -MP
CP_CXXFLAGS = -MMD -MP -std=c++11


CC     = gcc
CXX    = g++
YACC   = bison -y
YFLAGS ?= -v
LEX    = flex
HOSTCXX ?= $(CXX)
CP_CFLAGS += $(CFLAGS) $(INCLUDES)
CP_CXXFLAGS += $(CXXFLAGS) $(INCLUDES)

OBJ += $(patsubst $(SOURCEDIR)/%.cpp, $(BUILDDIR)/%$(OBJEXT), $(filter %.cpp, $(SRC)))
OBJ += $(patsubst $(SOURCEDIR)/%.cc, $(BUILDDIR)/%$(OBJEXT), $(filter %.cc, $(SRC)))


#llvm part starts
$(info -----------------------------------------------)
$(info Using SOURCEDIR = $(SOURCEDIR))
$(info Using BUILDDIR = $(BUILDDIR))
$(info Using LLVM_SRC_PATH = $(LLVM_SRC_PATH))
$(info Using LLVM_BUILD_PATH = $(LLVM_BUILD_PATH))
$(info Using LLVM_BIN_PATH = $(LLVM_BIN_PATH))
$(info Using CBMC_SRC_PATH = $(CBMC_SRC_PATH))
$(info Using MY_PROGR = $(MY_PROGR))
$(info -----------------------------------------------)

PLUGIN_CXXFLAGS := -fpic
LLVM_CXXFLAGS := `$(LLVM_BIN_PATH)/llvm-config --cxxflags`
LLVM_LDFLAGS := `$(LLVM_BIN_PATH)/llvm-config --ldflags --libs --system-libs`
LLVM_LDFLAGS_NOLIBS := `$(LLVM_BIN_PATH)/llvm-config --ldflags`
PLUGIN_LDFLAGS := -shared
CLANG_INCLUDES := \
	-I$(LLVM_SRC_PATH)/tools/clang/include \
	-I$(LLVM_BUILD_PATH)/tools/clang/include
	CLANG_LIBS := \
		-Wl,--start-group \
		-lclangAST \
		-lclangASTMatchers \
		-lclangAnalysis \
		-lclangBasic \
		-lclangDriver \
		-lclangEdit \
		-lclangFrontend \
		-lclangFrontendTool \
		-lclangLex \
		-lclangParse \
		-lclangSema \
		-lclangEdit \
		-lclangRewrite \
		-lclangRewriteFrontend \
		-lclangStaticAnalyzerFrontend \
		-lclangStaticAnalyzerCheckers \
		-lclangStaticAnalyzerCore \
		-lclangSerialization \
		-lclangToolingCore \
		-lclangTooling \
		-lclangFormat \
		-Wl,--end-group

LINKBIN =$(CXX)  $(LINKFLAGS) -o $@ -Wl,--start-group $^ $(LLVM_LDFLAGS) $(LLVM_LDFLAGS_NOLIBS) -Wl,--end-group $(LIBS)


.SUFFIXES: .cc .d .cpp

$(BUILDDIR)/%.o:$(SOURCEDIR)/%.cpp
	@echo Compiling $< ...
	@$(CXX) -c  $(CP_CXXFLAGS) $(PLUGIN_CXXFLAGS) $(LLVM_CXXFLAGS) -fexceptions -o $@ $<


D_FILES1 = $(SRC:.c=.d)
D_FILES = $(D_FILES1:.cpp=.d)

-include $(D_FILES)

CLEANFILES = $(subst $(SOURCEDIR),$(BUILDDIR),$(subst .cpp,.o,$(SRC)) )
CLEANFILES += $(subst $(SOURCEDIR),$(BUILDDIR),$(subst .cpp,.d,$(SRC)) )
# CLEANFILES += $(subst .cpp,.d,$(SRC))
CLEANFILES += $(MY_PROGR)$(EXEEXT)


.PHONY: all
all: makebuilddir $(MY_PROGR)$(EXEEXT)
	@echo COMPLETED

.PHONY:makebuilddir
makebuilddir:
	@mkdir -p $(BUILDDIR)

.PHONY: rebuild
rebuild: clean all

.PHONY:clean
clean:
	@echo Removing following Generated Files :
	@echo $(CLEANFILES)
	@rm -rf $(CLEANFILES)


ifneq ($(wildcard $(CBMC_SRC_PATH)/bv_refinement/Makefile),)
  OBJ += $(CBMC_SRC_PATH)/bv_refinement/bv_refinement$(LIBEXT)
  CP_CXXFLAGS += -DHAVE_BV_REFINEMENT
endif

ifneq ($(wildcard $(CBMC_SRC_PATH)/java_bytecode/Makefile),)
  OBJ += $(CBMC_SRC_PATH)/java_bytecode/java_bytecode$(LIBEXT)
  CP_CXXFLAGS += -DHAVE_JAVA_BYTECODE
endif

ifneq ($(wildcard $(CBMC_SRC_PATH)/jsil/Makefile),)
  OBJ += $(CBMC_SRC_PATH)/jsil/jsil$(LIBEXT)
  CP_CXXFLAGS += -DHAVE_JSIL
endif

ifneq ($(wildcard $(CBMC_SRC_PATH)/specc/Makefile),)
  OBJ += $(CBMC_SRC_PATH)/specc/specc$(LIBEXT)
  CP_CXXFLAGS += -DHAVE_SPECC
endif

ifneq ($(wildcard $(CBMC_SRC_PATH)/php/Makefile),)
  OBJ += $(CBMC_SRC_PATH)/php/php$(LIBEXT)
  CP_CXXFLAGS += -DHAVE_PHP
endif

.PHONY:$(MY_PROGR)$(EXEEXT)
$(MY_PROGR)$(EXEEXT): $(OBJ)
	@echo "Linking Generated Files..."
	@$(LINKBIN)
