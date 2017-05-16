NAME = fabriziopandini/pause
VERSION = 0.2
BASE = alpine scratch debian ubuntu centos alpine-dev ubuntu-dev
TEST_TARGET = alpine

all: package

package:
	@$(foreach base,${BASE},docker run --rm -v $(PWD):/src -v /var/run/docker.sock:/var/run/docker.sock -e DOCKERFILE=Dockerfile.${base} fabriziopandini/golang-builder $(NAME):$(VERSION)-${base};) 

test_package: 
	@docker run --rm $(NAME):$(VERSION)-$(TEST_TARGET)
    
tag: 
	@$(foreach base,${BASE},docker tag $(NAME):$(VERSION)-$(base) $(NAME):latest-$(base);) \
	docker tag $(NAME):$(VERSION)-alpine $(NAME):latest 
    
push: 
	@docker push $(NAME)
	
rmi: 
	@$(foreach base,${BASE},docker rmi $(NAME):$(VERSION)-$(base) $(NAME):latest-$(base);) \
	docker rmi $(NAME):$(VERSION)-alpine $(NAME):latest 