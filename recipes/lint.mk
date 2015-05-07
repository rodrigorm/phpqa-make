.PHONY : phpqa-lint

phpqa-build : phpqa-lint
phpqa-clean : phpqa-lint-clean

# Perform syntax check of sourcecode files
phpqa-lint : $(patsubst %.php,$(BUILDDIR)/lint/%.php.log,$(SRC) $(TESTS))
$(BUILDDIR)/lint/%.php.log : %.php
	@mkdir -p "$(dir $@)"
	@php -l "$<" | tee "$@"

phpqa-lint-clean :
	@rm -rf "$(BUILDDIR)/lint"
