.PHONY: check lint format quality

check:
	./scripts/check-prerequisites.sh

generate-server-keys:
	sudo ./scripts/generate-server-keys.sh

lint:
	shellcheck -x scripts/*.sh

format:
	shfmt -d .

quality: lint format
