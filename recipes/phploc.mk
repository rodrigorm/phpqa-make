PHPLOC ?= $(BIN)/phploc

.PHONY : phpqa-phploc

phpqa-build : phpqa-phploc
phpqa-clean : phpqa-phploc-clean

# Measure project size using PHPLOC
phpqa-phploc : $(LOGSDIR)/phploc.csv
$(LOGSDIR)/phploc.csv : $(SRC) | $(LOGSDIR) $(PHPLOC)
	@$(PHPLOC) --log-csv "$(LOGSDIR)/phploc.csv" $(SRC)

phpqa-phploc-clean :
	@rm -f "$(LOGSDIR)/phploc.csv"
