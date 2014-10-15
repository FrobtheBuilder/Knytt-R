default: src

src:
	cd moon; \
	moonc -t ../lua *.moon

lovekit::
	cd moon/lib/lovekit; \
	moonc -t ../../../lua/lib lovekit && rm -r ../../../lua/lib/lovekit/.git

clean:
	bash -c "rm lua/"*.lua"; rm -r lua/lib/lovekit"