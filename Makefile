all: .yowcow-terraformer.json

.yowcow-terraformer.json: yowcow-terraformer.json.gpg
	gpg --decrypt --output $@ $<
