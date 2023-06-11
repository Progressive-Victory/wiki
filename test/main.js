/* eslint-disable no-undef */

const { assert } = require('chai');
const axios = require('axios');
const https = require('https');

require('dotenv').config();

const url = process.env.MW_SITE_SERVER || 'https://localhost';
// const resources = process.env.RESOURCES_PATH || 'resources/assets/images';

const httpsAgent = new https.Agent({ rejectUnauthorized: false })

describe('MediaWiki', function() {
	it('should return a 200 status code', async function() {
		const response = await axios.get(url, { httpsAgent });
		assert.equal(response.status, 200);
	});

	/*
	it('should return the correct title', async function() {
		const response = await axios.get(url, { httpsAgent });
		assert.include(response.data, '<title>Progressive Victory Wiki</title>');
	});

	it('should return the correct logo', async function() {
		const response = await axios.get(url, { httpsAgent });
		assert.include(response.data, `${resources}/logo.svg`);
	});

	it('should return the correct wordmark', async function() {
		const response = await axios.get(url, { httpsAgent });
		assert.include(response.data, `${resources}/wordmark.svg`);
	});

	it('should return the correct icon', async function() {
		const response = await axios.get(url, { httpsAgent });
		assert.include(response.data, `${resources}/icon.svg`);
	});
	*/

	it('should return the correct search page', async function() {
		const response = await axios.get(`${url}/index.php?search=test&title=Special%3ASearch&go=Go`, { httpsAgent });
		assert.notInclude(response.data, 'DBQueryError');
	});
});
