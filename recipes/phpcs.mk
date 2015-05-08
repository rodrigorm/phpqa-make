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
$(LOGSDIR)/checkstyle.xml : $(SRC) phpcs.xml | $(LOGSDIR) $(PHPCS)
	@$(PHPCS) --report=checkstyle --report-file="$(LOGSDIR)/checkstyle.xml" --standard="phpcs.xml" $(SRCDIR); true

phpqa-phpcs-clean :
	@rm -rf "$(LOGSDIR)/phpcs"
	@rm -f "$(LOGSDIR)/checkstyle.xml"
