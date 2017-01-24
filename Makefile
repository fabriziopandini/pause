NAME = fabriziopandini/pause
VERSION = 0.1
BASE = alpine scratch debian ubuntu centos
TEST_TARGET = centos

all: package

package:
	@$(foreach base,${BASE},docker run --rm -v $(PWD):/src -v /var/run/docker.sock:/var/run/docker.sock -e DOCKERFILE=Dockerfile.${base} fabriziopandini/golang-builder $(NAME):$(VERSION)-${base};) 

test_package: 
	@docker run --rm $(NAME):$(VERSION)-$(TEST_TARGET)
    
tag: 
	@$(foreach base,${BASE}, docker tag $(NAME):$(VERSION)-$(base) $(NAME):latest-$(base);) \ 
	docker tag $(NAME):$(VERSION)-$(BASE[0]) $(NAME):latest 
    
push: 
	docker push $(NAME)
	
