-include Makefile.config

UNIKERNELS = \
  00-hello \
  01-app-info \
  02-dns-client \
  03-web-client \
  04-web-server \
  05-resolver

MODE ?= "unix"

BUILD  = $(patsubst %, %-build, $(UNIKERNELS))
CI     = $(patsubst %, %-ci, $(UNIKERNELS))
CLEAN  = $(patsubst %, %-clean, $(UNIKERNELS))

build: $(BUILD)
ci: $(CI)
clean: $(CLEAN)

%-build:
	cd $* && \
	mirage configure -t $(MODE) $(MIRAGE_FLAGS) && \
	$(MAKE)

%-ci:
	cd $* && \
	mirage configure -t $(MODE) $(MIRAGE_FLAGS) && \
	make depend && \
	$(MAKE)

%-clean:
	-cd $* && mirage clean
