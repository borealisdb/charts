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

check.github.token:
ifndef GITHUB_TOKEN
	$(error GITHUB_TOKEN is undefined)
endif

release: check.github.token publish
	git tag $(TAG)
	git push --tags
	export $(cat secrets.env | xargs) && goreleaser release --clean