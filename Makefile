VERSION := 5.3.2
DOWNLOAD_URL := https://github.com/twbs/bootstrap/releases/download/v$(VERSION)/bootstrap-$(VERSION)-dist.zip
DOWNLOADED_FILE := build/bootstrap-dist.zip
STATIC_DIR := bootstrap5/static


VENV_DIR := .venv
PYTHON_BIN := $(VENV_DIR)/bin/python
PIP_BIN := $(VENV_DIR)/bin/pip

# Bootstrap Dependencies

$(STATIC_DIR)/: build/bootstrap-$(VERSION)-dist
	rsync -vr build/bootstrap-$(VERSION)-dist/ $(STATIC_DIR)

build/bootstrap-$(VERSION)-dist/: $(DOWNLOADED_FILE)
	unzip $(DOWNLOADED_FILE) -d build

$(DOWNLOADED_FILE):
	mkdir build
	curl -L --output $(DOWNLOADED_FILE) $(DOWNLOAD_URL)

# Python Packaging

$(VENV_DIR):
	python3 -m venv $(VENV_DIR)
	$(PIP_BIN) install --upgrade wheel pip

.PHONY: build
build: $(VENV_DIR) $(STATIC_DIR)
	$(PYTHON_BIN) setup.py sdist bdist_wheel

# Other

.PHONY: reset
reset:
	rm -rf $(STATIC_DIR)

.PHONY: clean
clean:
	rm -rf build dist $(VENV_DIR)
	git clean -dxf $(STATIC_DIR)
