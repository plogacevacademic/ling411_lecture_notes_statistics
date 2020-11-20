all:
	Rscript -e 'rmarkdown::render("./index.Rmd")'
	git add *
	git commit -a -m update
	git push
#	cd website
# make
