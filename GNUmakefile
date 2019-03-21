-include Makefile.config

UNIKERNELS = \
  00-hello \
  01-app-info \
  02-dns-client \
  03-web-client \
  04-web-server \
  05-resolver

MODE ?= "unix"

BUILD  = $(patsubst %, %-unikernel, $(UNIKERNELS))
CLEAN  = $(patsubst %, %-clean, $(UNIKERNELS))

build: $(BUILD)
clean: $(CLEAN)

%-unikernel:
	cd $* && \
	mirage configure -t $(MODE) $(MIRAGE_FLAGS) && \
	$(MAKE) depend && \
	$(MAKE)

%-clean:
	-cd $* && mirage clean
