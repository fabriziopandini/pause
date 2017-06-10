NAME = fabriziopandini/pause
BASE = alpine scratch debian ubuntu centos

all: package

build:
	go build 

test:
	./pause

build.package:
	docker run --rm -v $(PWD):/src fabriziopandini/golang-builder 

package: build.package
	@$(foreach base,${BASE},cp pause ${base}/;cd ${base}/;docker build --rm -t ${NAME}:${base} .;cd ..;) 

rmi: 
	@$(foreach base,${BASE},docker rmi ${NAME}:${base};) 

