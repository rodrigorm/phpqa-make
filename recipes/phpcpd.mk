PHPCPD ?= $(BIN)/phpcpd

.PHONY : phpqa-phpcpd

phpqa-build : phpqa-phpcpd
phpqa-pre-commit : phpqa-phpcpd
phpqa-clean : phpqa-phpcpd-clean

# Find duplicate code using PHPCPD
phpqa-phpcpd : $(LOGSDIR)/pmd-cpd.xml
$(LOGSDIR)/pmd-cpd.xml : $(SRC) | $(LOGSDIR)
	@$(PHPCPD) --log-pmd "$(LOGSDIR)/pmd-cpd.xml" $(SRC); true

phpqa-phpcpd-clean :
	@rm -f "$(LOGSDIR)/pmd-cpd.xml"
