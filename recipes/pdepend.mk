PDEPEND ?= $(BIN)/pdepend

EMPTY =
SPACE = $(EMPTY) $(EMPTY)
COMMA = ,

srcdirlist = $(subst $(SPACE),$(COMMA),$(SRCDIR))

.PHONY : phpqa-pdepend

phpqa-build : phpqa-pdepend
phpqa-clean :phpqa-pdepend-clean

# Calculate software metrics using PHP_Depend
phpqa-pdepend : $(LOGSDIR)/jdepend.xml
$(LOGSDIR)/jdepend.xml : $(SRC) | $(BUILDDIR)/pdepend $(LOGSDIR) $(PDEPEND)
	@$(PDEPEND) --jdepend-xml="$(LOGSDIR)/jdepend.xml" --jdepend-chart="$(BUILDDIR)/pdepend/dependencies.svg" --overview-pyramid="$(BUILDDIR)/pdepend/overview-pyramid.svg" $(srcdirlist)

$(BUILDDIR)/pdepend :
	@mkdir -p "$@"

phpqa-pdepend-clean :
	@rm -rf "$(BUILDDIR)/pdepend"
	@rm "$(LOGSDIR)/jdepend.xml"
