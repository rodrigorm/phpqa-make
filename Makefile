BUILDDIR ?= build
SRCDIR ?= src
TESTSDIR ?= tests
LOGSDIR ?= $(BUILDDIR)/logs
EXCLUDES ?=

excludes := $(addprefix ! -path ",$(addsuffix ",$(EXCLUDES)))
SRC ?= $(shell find $(value SRCDIR) -type f -name "*.php" $(value excludes))
TESTS ?= $(shell find $(value TESTSDIR) -type f -name "*.php" $(value excludes))

BIN ?= vendor/bin

mkfile_path = $(abspath $(lastword $(MAKEFILE_LIST)))
mkfile_dir = $(dir $(mkfile_path))
RECIPESDIR = $(mkfile_dir)/recipes

include $(shell find $(RECIPESDIR) -iname "*.mk")

$(BUILDDIR) $(LOGSDIR) :
	@mkdir -p "$@"
