# per-project info
PACKAGE:=github.com/ferrum/fe
BINARY:=fe 

# shouldn't probably change between projects
WORKSPACE:=$(PWD)/_workspace
BRANCH:=$(shell git branch | grep '^* ' | awk '{print $$2'})

$(BINARY): workspace
	git checkout project
	make
	git checkout $(BRANCH)

workspace: $(WORKSPACE)/src/$(PACKAGE)

$(WORKSPACE)/src/$(PACKAGE):
	mkdir -p $(WORKSPACE)/src/$(PACKAGE)
	git clone . $(WORKSPACE)/src/$(PACKAGE)
	cp .git/config $(WORKSPACE)/src/$(PACKAGE)/.git/
	cd $(WORKSPACE)/src/$(PACKAGE) && git checkout $(BRANCH)


project:
	git checkout project

go1:
	git checkout go1

master:
	git checkout master

clean:
	rm -rf $(WORKSPACE) $(BINARY)
