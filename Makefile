CHART_DOMAIN ?= https://borealisdb.github.io/charts
CHART_PATH ?= ./borealis
TAG ?= $$(svu next)

helm.version:
	node ./scripts/index.js $$(svu next --strip-prefix) $(CHART_PATH)

helm.package:
	helm package borealis/ -d docs/ && helm repo index docs --url $(CHART_DOMAIN)

release:
	git tag $(TAG)
	git push --tags
	#goreleaser release --clean