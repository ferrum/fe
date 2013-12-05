WORKSPACE:=$(PWD)/_workspace
PACKAGE=github.com/ferrum/fe

fe: project $(WORKSPACE)/src/$(PACKAGE)
	GOPATH=$(WORKSPACE) go install $(PACKAGE)
	cp $(WORKSPACE)/bin/fe .
	git checkout master

project:
	git checkout project

go1:
	git checkout go1

master:
	git checkout master

$(WORKSPACE)/src/github.com/ferrum/fe:
	mkdir -p $(WORKSPACE)/src/github.com/ferrum/
	git clone https://$(PACKAGE).git $(WORKSPACE)/src/$(PACKAGE)

clean:
	rm -rf $(WORKSPACE) fe 
