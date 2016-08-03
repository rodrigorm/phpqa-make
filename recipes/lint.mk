.PHONY : phpqa-lint

phpqa-build : phpqa-lint
phpqa-clean : phpqa-lint-clean

# Perform syntax check of sourcecode files
phpqa-lint : $(patsubst %.php,$(LOGSDIR)/lint/%.php.log,$(SRC) $(TESTS))
$(LOGSDIR)/lint/%.php.log : %.php
	@mkdir -p "$(dir $@)"
	@php -l "$<" | tee "$@"

phpqa-lint-clean :
	-rm -rf "$(LOGSDIR)/lint"
