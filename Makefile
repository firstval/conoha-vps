VERSION=$(shell cat VERSION)
NAME=conoha
BINDIR=bin
GOARCH=amd64
GOFLAGS=-ldflags "-X github.com/hironobu-s/conoha-vps/lib.Version $(VERSION)"

all: clean windows darwin linux

windows:
	GOOS=$@ GOARCH=$(GOARCH) go build $(GOFLAGS) -o $(BINDIR)/$@/$(NAME).exe
	cd bin/$@; zip $(NAME).$(GOARCH).zip $(NAME).exe

darwin:
	GOOS=$@ GOARCH=$(GOARCH) go build $(GOFLAGS) -o $(BINDIR)/$@/$(NAME)
	cd bin/$@; gzip -c $(NAME) > $(NAME)-osx.$(GOARCH).gz 

linux:
	GOOS=$@ GOARCH=$(GOARCH) go build $(GOFLAGS) -o $(BINDIR)/$@/$(NAME)
	cd bin/$@; gzip -c $(NAME) > $(NAME)-linux.$(GOARCH).gz

clean:
	rm -rf $(BINDIR)
