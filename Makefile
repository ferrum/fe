# per-project info
PACKAGE:=github.com/ferrum/fe
BINARY:=fe 

# shouldn't probably change between projects
WORKSPACE:=$(PWD)/_workspace
REMOTE:=$(shell git remote -v | grep origin | grep push | awk '{print $$2}')
BRANCH:=$(shell git branch | grep '*' | awk '{print $$2'})

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
	git clone . $(WORKSPACE)/src/$(PACKAGE)
	cd $(WORKSPACE)/src/$(PACKAGE) && \
	   git checkout $(BRANCH) && \
       git remote rename origin project && \
	   git remote add -f origin $(REMOTE) && \
	   git branch -u origin/$(BRANCH)

clean:
	rm -rf $(WORKSPACE) $(BINARY)
