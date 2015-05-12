PHPUNIT ?= $(BIN)/phpunit

.PHONY : phpqa-phpunit phpqa-phpunit-ci

phpqa-build : phpqa-phpunit-ci
phpqa-pre-commit : phpqa-phpunit
phpqa-clean : phpqa-phpunit-clean

# Run unit tests with PHPUnit
phpqa-phpunit : $(SRC) $(TESTS) $(TESTSDIR)/phpunit.xml
	@$(PHPUNIT) -c $(TESTSDIR)/phpunit.xml

# Run unit tests with PHPUnit and generate coverage
phpqa-phpunit-ci : $(LOGSDIR)/junit.xml
$(LOGSDIR)/junit.xml : $(SRC) $(TESTS) phpunit.xml.dist | $(LOGSDIR)
	@$(PHPUNIT) || rm "$@"

phpqa-phpunit-clean :
	@rm -rf "$(LOGSDIR)/coverage"
	@rm -f "$(LOGSDIR)/junit.xml"
	@rm -f "$(LOGSDIR)/coverage.cov"
	@rm -f "$(LOGSDIR)/clover.xml"
