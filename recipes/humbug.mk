HUMBUG ?= $(BIN)/humbug

.PHONY : phpqa-humbug phpqa-humbug-ci

phpqa-build : phpqa-humbug
phpqa-pre-commit : phpqa-humbug
phpqa-clean : phpqa-humbug-clean

phpqa-humbug : $(LOGSDIR)/humbug.json
$(LOGSDIR)/humbug.json : $(SRC) $(TESTS) humbug.json.dist | $(LOGSDIR)
	@$(HUMBUG) --log-json="$@" || rm "$@"

phpqa-humbug-clean :
	-rm -f "$(LOGSDIR)/humbug.json"
