NAME = fabriziopandini/pause
BASE = alpine scratch debian ubuntu centos

all: package

package:
	@$(foreach base,${BASE},docker run --rm -v $(PWD):/src -v /var/run/docker.sock:/var/run/docker.sock -e DOCKERFILE=Dockerfile.${base} fabriziopandini/golang-builder $(NAME):$(VERSION)-${base};) 

test_package: 
	@docker run --rm $(NAME)-$(TEST_TARGET)
	
rmi: 
	@$(foreach base,${BASE},docker rmi $(NAME):$(VERSION)-$(base) $(NAME):latest-$(base);) \
	docker rmi $(NAME):$(VERSION)-alpine $(NAME):latest 


build:
	go build 

test:
	./pause

build.package:
	docker run --rm -v $(PWD):/src fabriziopandini/golang-builder 

package:
	@$(foreach base,${BASE},cp pause ${base}/;cd ${base}/;docker build --rm -t fabriziopandini/golang-builder:${base} .;cd ..;) 
