.PHONY: check

check:
	./scripts/check-prerequisites.sh

generate-server-keys:
	sudo ./scripts/generate-server-keys.sh
