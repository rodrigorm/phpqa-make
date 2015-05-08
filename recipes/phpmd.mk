PHPMD ?= $(BIN)/phpmd
PHPQADEPEND ?= $(BIN)/phpqa-depend

EMPTY =
SPACE = $(EMPTY) $(EMPTY)
COMMA = ,

srcdirlist = $(subst $(SPACE),$(COMMA),$(SRCDIR))

.PHONY : phpqa-phpmd

phpqa-build : phpqa-phpmd
phpqa-pre-commit : phpqa-phpmd
phpqa-clean : phpqa-phpmd-clean

# Perform project mess detection using PHPMD creating a log file for the continuous integration server
phpqa-phpmd : $(LOGSDIR)/pmd.xml
$(LOGSDIR)/pmd.xml :
	@echo '<?xml version="1.0" encoding="UTF-8" ?>' > "$@"
	@echo '<pmd version="@project.version@" timestamp="$(shell date --rfc-3339=ns)">' >> "$@"
	@(find "$(LOGSDIR)/phpmd" -name "*.php.xml" -print0 | xargs -0 grep -vh '</\?pmd\|<?xml') >> "$@"
	@echo '</pmd>' >> "$@"

$(LOGSDIR)/phpmd/%.php.xml : %.php phpmd.xml | $(PHPMD)
	@mkdir -p "$(dir $@)"
	@$(PHPMD) "$<" text "phpmd.xml" --reportfile-xml "$@"; true

-include phpmd.mk

phpmd.mk :
	@$(PHPQADEPEND) $(srcdirlist) "phpmd.xml" > "$@"

phpqa-phpmd-clean :
	@rm -rf "$(LOGSDIR)/phpmd"
	@rm "$(LOGSDIR)/pmd.xml"
	@rm phpmd.mk
