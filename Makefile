all: mlton mosml

install: mlton-create-link mosml-create-link

clean: mlton-clean mosml-clean

include Makefile.mlton
include Makefile.mosml


