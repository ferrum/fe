# per-project info
PACKAGE:=github.com/ferrum/fe
BINARY:=fe 

# shouldn't probably change between projects
WORKSPACE:=$(PWD)/_workspace

$(BINARY): workspace
	GOPATH=$(WORKSPACE) go install $(PACKAGE)
	cp $(WORKSPACE)/bin/fe .

workspace: $(WORKSPACE)/src/$(PACKAGE)

$(WORKSPACE)/src/$(PACKAGE):
	mkdir -p $(WORKSPACE)/src/$(PACKAGE)
	git clone . $(WORKSPACE)/src/$(PACKAGE)
	cp .git/config $(WORKSPACE)/src/$(PACKAGE)/.git/
	cd $(WORKSPACE)/src/$(PACKAGE) && git checkout master

activate: workspace
	@/bin/bash ./local.bash activate

work: activate

clean:
	rm -f $(WORKSPACE)/bin/$(BINARY) $(BINARY)

dist-clean: clean
	rm -rf $(WORKSPACE) $(BINARY)

project:
	git checkout project

go1:
	git checkout go1

master:
	git checkout master
