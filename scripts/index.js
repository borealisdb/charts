#!/usr/bin/env node

const fsPromises = require('fs').promises;
const path = require('path');
const yaml = require('js-yaml');

const version = process.argv[2];
const chartPath = process.argv[3];

console.log(`Updating Chart.yaml at ${chartPath} with version ${version}`);

const filePath = path.join(chartPath, 'Chart.yaml');

fsPromises.readFile(filePath)
    .then(chartYaml => {
        const oldChart = yaml.load(chartYaml);
        const newChart = yaml.dump({...oldChart, version: version, appVersion: version});
        return fsPromises.writeFile(filePath, newChart);
    }).then(() => {
        console.log("chart updated")
    }).catch((e) => {
        console.error(e)
        process.exit(1)
    })