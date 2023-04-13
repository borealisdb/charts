CHART_DOMAIN ?= https://borealisdb.github.io/charts
CHART_PATH ?= ./tmp/borealis
TAG ?= $$(svu next)

prepare:
	mkdir -p tmp/
	cp -r borealis/ tmp/borealis

helm.version:
	node ./scripts/index.js $$(svu next --strip-prefix) $(CHART_PATH)

helm.package:
	helm package $(CHART_PATH) -d docs/ && helm repo index docs --url $(CHART_DOMAIN)

build: prepare helm.version helm.package

publish: build
	git add -A && git commit -m "chore(): built helm chart artifacts" && git push origin master

release: publish
	git tag $(TAG)
	git push --tags
	goreleaser release --clean