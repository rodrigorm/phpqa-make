PDEPEND ?= $(BIN)/pdepend

EMPTY =
SPACE = $(EMPTY) $(EMPTY)
COMMA = ,

srcdirlist = $(subst $(SPACE),$(COMMA),$(SRCDIR))
excludeslist := $(subst $(SPACE),$(COMMA),$(addprefix */,$(EXCLUDES)))

.PHONY : phpqa-pdepend

phpqa-build : phpqa-pdepend
phpqa-clean :phpqa-pdepend-clean

# Calculate software metrics using PHP_Depend
phpqa-pdepend : $(LOGSDIR)/jdepend.xml
$(LOGSDIR)/jdepend.xml : $(SRC) | $(LOGSDIR)/pdepend $(LOGSDIR) $(PDEPEND)
	@$(PDEPEND) --jdepend-xml="$(LOGSDIR)/jdepend.xml" --jdepend-chart="$(LOGSDIR)/pdepend/dependencies.svg" --overview-pyramid="$(LOGSDIR)/pdepend/overview-pyramid.svg" --ignore="$(excludeslist)" $(srcdirlist)

$(LOGSDIR)/pdepend :
	@mkdir -p "$@"

phpqa-pdepend-clean :
	@rm -rf "$(LOGSDIR)/pdepend"
	@rm -f "$(LOGSDIR)/jdepend.xml"
