PHPCS ?= $(BIN)/phpcs

.PHONY : phpqa-phpcs phpqa-phpcs-ci

phpqa-build : phpqa-phpcs-ci
phpqa-pre-commit : phpqa-phpcs
phpqa-clean : phpqa-phpcs-clean

# Find coding standard violations using PHP_CodeSniffer and print human readable output. Intended for usage on the command line before committing.
phpqa-phpcs : $(patsubst %.php,$(LOGSDIR)/phpcs/%.php.log,$(SRC))
$(LOGSDIR)/phpcs/%.php.log : %.php
	@mkdir -p "$(dir $@)"
	@$(PHPCS) --standard="phpcs.xml" "$<" | tee $@

# Find coding standard violations using PHP_CodeSniffer creating a log file for the continuous integration server
phpqa-phpcs-ci : $(LOGSDIR)/checkstyle.xml
$(LOGSDIR)/checkstyle.xml : $(SRC:%.php=$(LOGSDIR)/phpcs/%.php.xml)
	@echo '<?xml version="1.0" encoding="UTF-8" ?>' > "$@"
	@echo '<checkstyle version="2.3.2">' >> "$@"
	@(find "$(LOGSDIR)/phpcs" -name "*.php.xml" -print0 | xargs -0 grep -vh '</\?checkstyle\|<?xml') >> "$@"
	@echo '</checkstyle>' >> "$@"

$(LOGSDIR)/phpcs/%.php.xml : %.php phpcs.xml | $(PHPCS)
	@mkdir -p "$(dir $@)"
	@$(PHPCS) --report=checkstyle --report-file="$@" --standard="phpcs.xml" $<; true

phpqa-phpcs-clean :
	@rm -rf "$(LOGSDIR)/phpcs"
	@rm -f "$(LOGSDIR)/checkstyle.xml"
