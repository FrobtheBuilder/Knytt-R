default: run

src:
	cd moon; \
	moonc -t ../lua *.moon

run: src
	love lua

lovekit::
	cd moon/lib/lovekit; \
	moonc -t ../../../lua lovekit

clean:
	bash -c "rm lua/"*.lua"; rm -r lua/lovekit"