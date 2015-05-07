PHPMD ?= $(BIN)/phpmd
PHPQADEPEND ?= $(BIN)/phpqa-depend

.PHONY : phpqa-phpmd

phpqa-build : phpqa-phpmd
phpqa-pre-commit : phpqa-phpmd
phpqa-clean : phpqa-phpmd-clean

# Perform project mess detection using PHPMD creating a log file for the continuous integration server
phpqa-phpmd : $(LOGSDIR)/pmd.xml
$(LOGSDIR)/pmd.xml :
	@echo '<?xml version="1.0" encoding="UTF-8" ?>' > "$@"
	@echo '<pmd version="@project.version@" timestamp="$(shell date --rfc-3339=ns)">' >> "$@"
	@(find "$(BUILDDIR)/phpmd" -name "*.php.xml" -print0 | xargs -0 grep -vh '</\?pmd\|<?xml') >> "$@"
	@echo '</pmd>' >> "$@"

$(BUILDDIR)/phpmd/%.php.xml : %.php $(BUILDDIR)/phpmd.xml | $(PHPMD)
	@mkdir -p "$(dir $@)"
	@$(PHPMD) "$<" text "$(BUILDDIR)/phpmd.xml" --reportfile-xml "$@"; true

-include phpmd.mk

phpmd.mk :
	@$(PHPQADEPEND) > "$@"

phpqa-phpmd-clean :
	@rm -rf "$(BUILDDIR)/phpmd"
	@rm "$(LOGSDIR)/pmd.xml"
	@rm phpmd.mk
