# Rules that should run regardless of files state
.PHONY: all build clean

all: build

# Environment Variables
BUILD_DIR ?= build/  ## Directory for build files (pdf, artifacts)

# Latexmk Configuration

# -pdf tells latexmk to generate a PDF directly (instead of DVI).
# -lualatex tells latexmk to use the `lualatex` backend.
# -use-make tells latexmk to call make to generate missing files.
# -jobname gives the name of the output pdf file
# -outdir gives the folder for the output file and artifacts
# -quiet suppresses logs

BUILD_OPTIONS := -pdf -quiet -lualatex -jobname=resume -use-make -outdir=$(BUILD_DIR)

# Colours Variables - to use colour in 'make help' prints
BLUE := \033[36m
GREY := \033[37m
RESET := \033[0m
BOLD := \033[1m

build: resume.tex  ## Build the resume
	latexmk $(BUILD_OPTIONS) -f resume.tex

preview: resume.tex  ## Builds the resume with preview and reload options
	# The -pvc option turns on the preview and reload mode
	latexmk $(BUILD_OPTIONS) -pvc resume.tex

clean:  ## Cleans up build files
	latexmk -CA -outdir=$(BUILD_DIR) resume.tex

# Implements this pattern for autodocumenting Makefiles:
# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
#
# Picks up all comments that start with a ## and are at the end of a target definition line.
.PHONY: help
help:  ## Display command usage
	@printf '$(BOLD)Commands$(RESET)\n'
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "$(BLUE)%-40s$(RESET) %s\n", $$1, $$2}'
	@printf '$(BOLD)Environment Variables$(RESET)\n'
	@grep -E '^[0-9a-zA-Z_]+ \?=.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = " (\\?=|##) "}; {printf "$(BLUE)%-20s$(GREY)%-20s$(RESET) %s\n", $$1, $$2,$$3}'

