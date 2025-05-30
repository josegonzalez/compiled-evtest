ARCHITECTURES := arm arm64

EVTEST_VERSION := 1.35

clean:
	rm -f bin/*/evtest || true

build: $(foreach arch,$(ARCHITECTURES),bin/$(arch)/evtest)

bin/%/evtest:
	mkdir -p bin/$*
	docker buildx build --platform linux/$* --load -f $*/Dockerfile --build-arg EVTEST_VERSION=$(EVTEST_VERSION) --progress plain -t app/evtest:$(EVTEST_VERSION)-$* $*/
	docker container create --name extract app/evtest:$(EVTEST_VERSION)-$*
	docker container cp extract:/go/src/github.com/freedesktop/evtest/evtest bin/$*/evtest
	docker container rm extract
	chmod +x bin/$*/evtest
