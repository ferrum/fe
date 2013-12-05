WORKSPACE:=$(PWD)/_workspace
PACKAGE=github.com/ferrum/fe

fe: project $(WORKSPACE)/src/$(PACKAGE)
	GOPATH=$(WORKSPACE) go install $(PACKAGE)
	cp $(WORKSPACE)/bin/fe .

project:
	git checkout project

$(WORKSPACE)/src/github.com/ferrum/fe:
	mkdir -p $(WORKSPACE)/src/github.com/ferrum/
	git clone https://$(PACKAGE).git $(WORKSPACE)/src/$(PACKAGE)

clean:
	rm -f $(WORKSPACE) fe 