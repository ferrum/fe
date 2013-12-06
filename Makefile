# per-project info
PACKAGE:=github.com/ferrum/fe
BINARY:=fe 

# shouldn't probably change between projects
WORKSPACE:=$(PWD)/_workspace
BRANCH:=$(shell git branch | grep '^* ' | awk '{print $$2'})

$(BINARY): 
	git checkout project
	make
	git checkout $(BRANCH)

project:
	git checkout project

go1:
	git checkout go1

master:
	git checkout master

$(WORKSPACE)/src/github.com/ferrum/fe:
	mkdir -p $(WORKSPACE)/src/$(PACKAGE)
	git clone . $(WORKSPACE)/src/$(PACKAGE)
	cp .git/config $(WORKSPACE)/src/$(PACKAGE)/.git/
	cd $(WORKSPACE)/src/$(PACKAGE) && git checkout $(BRANCH)

clean:
	rm -rf $(WORKSPACE) $(BINARY)
