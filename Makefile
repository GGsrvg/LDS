.PHONY: push

push:
ifdef tag
	@git commit -am ${tag}
	@git push
	@git tag ${tag}
	@git push --tags
	@pod trunk push LDS.podspec
else
	@echo 'need set argument "tag"'
endif