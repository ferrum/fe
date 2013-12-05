WORKSPACE:=$(PWD)/workspace
PACKAGE=github.com/ferrum/fe

fe: $(WORKSPACE)/src/$(PACKAGE)
	GOPATH=$(WORKSPACE) go install $(PACKAGE)
	cp $(WORKSPACE)/bin/fe .

$(WORKSPACE)/src/github.com/ferrum/fe:
	mkdir -p $(WORKSPACE)/src/github.com/ferrum/
	git clone https://$(PACKAGE).git $(WORKSPACE)/src/$(PACKAGE)

activate:
	@/bin/bash ./local.bash activate

work: activate

clean:
	rm -f $(WORKSPACE)/bin/fe fe

dist-clean: clean
	rm -rf fe $(WORKSPACE)

