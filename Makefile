BUILDDIR ?= build
SRCDIR ?= src
TESTSDIR ?= tests
LOGSDIR ?= $(BUILDDIR)/logs

SRC ?= $(shell find $(SRCDIR) -type f -name "*.php")
TESTS ?= $(shell find $(TESTSDIR) -type f -name "*.php")

BIN ?= vendor/bin

mkfile_path = $(abspath $(lastword $(MAKEFILE_LIST)))
mkfile_dir = $(dir $(mkfile_path))
RECIPESDIR = $(mkfile_dir)/recipes

include $(shell find $(RECIPESDIR) -iname "*.mk")

$(BUILDDIR) $(LOGSDIR) :
	@mkdir -p "$@"
