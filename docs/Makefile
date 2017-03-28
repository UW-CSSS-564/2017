HTML_FILES := $(patsubst %.Rmd, docs/%.html ,$(wildcard *.Rmd))

.PHONY: all
all: clean html

.PHONY: html
html: $(HTML_FILES)

docs/%.html: %.Rmd
	R --slave -e "rmarkdown::render_site('$<')"

.PHONY: clean
clean:
	Rscript _clean.R

.PHONY: serve
serve:
	Rscript -e 'servr::httd("docs")'
