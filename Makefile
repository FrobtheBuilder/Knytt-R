.PHONY: assets src run lovekit

default: run

src: assets
	cd src; \
	moonc -t ../built *.moon

run: src
	love built

lovekit::
	cd src/lib/lovekit; \
	moonc -t ../../../built lovekit

clean:
	bash -c "rm built/"*.lua"; rm -r built/lovekit; rm -r built/assets"

assets:
	cp -r assets built/