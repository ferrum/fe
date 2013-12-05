# per-project info
PACKAGE:=github.com/ferrum/fe
BINARY:=fe

# shouldn't probably change between projects
WORKSPACE:=$(PWD)/_workspace

$(BINARY): project $(WORKSPACE)/src/$(PACKAGE)
	GOPATH=$(WORKSPACE) go install $(PACKAGE)
	cp $(WORKSPACE)/bin/$(BINARY) .
	git checkout master

project:
	git checkout project

go1:
	git checkout go1

master:
	git checkout master

$(WORKSPACE)/src/github.com/ferrum/fe:
	mkdir -p $(WORKSPACE)/src/$(PACKAGE)
	git clone https://$(PACKAGE).git $(WORKSPACE)/src/$(PACKAGE)

clean:
	rm -rf $(WORKSPACE) $(BINARY)
