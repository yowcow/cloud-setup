CREDENTIALS := ./.yowcow-terraformer.json
TERRAFORM := TF_VAR_credentials=$(CREDENTIALS) terraform
TERRAFORM_TARGETS := fmt validate plan apply destroy

all: $(CREDENTIALS)
	$(TERRAFORM) init -backend-config="credentials=$(CREDENTIALS)"

$(CREDENTIALS): $(CREDENTIALS).gpg
	gpg --decrypt --output $@ $<

$(TERRAFORM_TARGETS):
	$(TERRAFORM) $@

.PHONY: all $(TERRAFORM_TARGETS)
