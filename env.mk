CREDENTIALS := ../../.yowcow-terraformer.json
TERRAFORM := TF_VAR_credentials=$(CREDENTIALS) terraform
TERRAFORM_TARGETS := init fmt validate plan apply destroy

all: $(CREDENTIALS)
	$(TERRAFORM) init -backend-config="credentials=$(CREDENTIALS)"

$(CREDENTIALS):
	$(MAKE) -C ../../ $(notdir $@)

$(TERRAFORM_TARGETS):
	$(TERRAFORM) $@

.PHONY: all $(TERRAFORM_TARGETS)
