all: mlton mosml

install: mlton-create-link mosml-create-link

include Makefile.mlton
include Makefile.mosml


