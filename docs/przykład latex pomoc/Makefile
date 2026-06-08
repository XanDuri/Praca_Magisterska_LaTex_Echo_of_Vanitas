PDFFILE = przyklad.pdf
TEXFILES = $(wildcard *.tex) $(wildcard *.cls) mwbk12.clo
SOURCES = $(PDFFILE) $(TEXFILES) README Makefile
LATEX = pdflatex

uwmthesis.zip: $(SOURCES)
	zip -j $@ $^

clean:
	rm -f uwmthesis.zip przyklad.pdf

%.pdf: %.tex
	$(LATEX) $<
	@if(grep "Rerun" $*.log > /dev/null);\
		then \
		$(LATEX) $<;\
	fi
	@if(grep "Rerun" $*.log > /dev/null);\
		then \
		$(LATEX) $<;\
	fi
