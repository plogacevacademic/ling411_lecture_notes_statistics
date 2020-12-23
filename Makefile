all:
	./generate.sh
	git add *
	git commit -a -m message
	git push
