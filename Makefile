CREDENTIALS := ./.yowcow-terraformer.json
MAKEFILES := ./env/common/Makefile ./env/x19-dev/Makefile ./env/x28-co/Makefile

all: $(CREDENTIALS) $(MAKEFILES)

$(CREDENTIALS): $(CREDENTIALS).gpg
	gpg --decrypt --output $@ $<

./env/%/Makefile: env.mk
	ln -snf $(abspath $<) $@
