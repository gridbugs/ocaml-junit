build:
	dune build

doc:
	dune build @doc

test:
	dune runtest

clean:
	dune clean

REPO=../opam-repository
PACKAGES=$(REPO)/packages

# until we have https://github.com/ocaml/opam-publish/issues/38
pkg-%:
	topkg opam pkg -n $*
	mkdir -p $(PACKAGES)/$*
	cp -r _build/$*.* $(PACKAGES)/$*/
	rm -f $(PACKAGES)/$*/$*.opam
	cd $(PACKAGES) && git add $*

PKGS=$(basename $(wildcard *.opam))
opam-pkg:
	$(MAKE) $(PKGS:%=pkg-%)

.PHONY: examples doc test build
