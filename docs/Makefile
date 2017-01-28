HTML_FILES := $(patsubst %.Rmd, docs/%.html ,$(wildcard *.Rmd))

all: clean html

html: $(HTML_FILES)

docs/%.html: %.Rmd
	R --slave -e "rmarkdown::render('$<')"

.PHONY: clean
clean:
	Rscript _clean.R
