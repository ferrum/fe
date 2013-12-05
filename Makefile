WORKSPACE:=$(PWD)/_workspace
PACKAGE=github.com/ferrum/fe

fe: workspace
	GOPATH=$(WORKSPACE) go install $(PACKAGE)
	cp $(WORKSPACE)/bin/fe .

workspace: $(WORKSPACE)/src/$(PACKAGE)

$(WORKSPACE)/src/github.com/ferrum/fe:
	mkdir -p $(WORKSPACE)/src/github.com/ferrum/
	git clone https://$(PACKAGE).git $(WORKSPACE)/src/$(PACKAGE)

activate: workspace
	@/bin/bash ./local.bash activate

work: activate

clean:
	rm -f $(WORKSPACE)/bin/fe fe

dist-clean: clean
	rm -rf fe $(WORKSPACE)

project:
	git checkout project

go1:
	git checkout go1

master:
	git checkout master
