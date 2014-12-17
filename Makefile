.PHONY: assets src run

default: run

src: 
	cd src; \
	moonc -t ../built *.moon

run: src
	love built

clean:
	bash -c "rm built/"*.lua"; rm -r built/lovekit; rm -r built/assets"

assets:
	cp -r assets built/