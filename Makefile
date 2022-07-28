VERSION := 4.6.2
DOWNLOAD_URL := https://github.com/twbs/bootstrap/releases/download/v4.6.2/bootstrap-4.6.2-dist.zip
DOWNLOADED_FILE := build/bootstrap-dist.zip
STATIC_DIR := bootstrap4/static

$(STATIC_DIR)/: build/bootstrap-$(VERSION)-dist
	rsync -r build/bootstrap-$(VERSION)-dist/ $(STATIC_DIR)

build/bootstrap-$(VERSION)-dist/: $(DOWNLOADED_FILE)
	unzip $(DOWNLOADED_FILE) -d build

$(DOWNLOADED_FILE):
	mkdir build
	curl -L --output $(DOWNLOADED_FILE) $(DOWNLOAD_URL)

clean:
	rm -rf $(STATIC_DIR)
