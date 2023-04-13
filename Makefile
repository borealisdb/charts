CHART_DOMAIN ?= https://charts.github.io/borealis

helm.package:
	helm package borealis/ -d docs/ && helm repo index docs --url $(CHART_DOMAIN)