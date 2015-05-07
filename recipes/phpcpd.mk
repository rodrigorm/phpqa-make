PHPCPD ?= $(BIN)/phpcpd

.PHONY : phpqa-phpcpd

phpqa-build : phpqa-phpcpd
phpqa-pre-commit : phpqa-phpcpd
phpqa-clean : phpqa-phpcpd-clean

# Find duplicate code using PHPCPD
phpqa-phpcpd : $(LOGSDIR)/pmd-cpd.xml
$(LOGSDIR)/pmd-cpd.xml : $(SRC) | $(LOGSDIR) $(PHPCPD)
	@$(PHPCPD) --log-pmd "$(LOGSDIR)/pmd-cpd.xml" $(SRCDIR)

phpqa-phpcpd-clean :
	@rm "$(LOGSDIR)/pmd-cpd.xml"
