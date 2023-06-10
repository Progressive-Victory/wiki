const { assert } = require('chai');
const axios = require('axios');

require('dotenv').config();

const url = process.env.MW_SITE_SERVER || 'https://localhost';
const resources = process.env.RESOURCES_PATH || 'resources/assets/images';

describe('MediaWiki', function() {
	it('should return a 200 status code', async function() {
		const response = await axios.get(url);
		assert.equal(response.status, 200);
	});

	it('should return the correct title', async function() {
		const response = await axios.get(url);
		assert.include(response.data, '<title>Progressive Victory Wiki</title>');
	});

	it('should return the correct logo', async function() {
		const response = await axios.get(url);
		assert.include(response.data, `${resources}/logo.svg`);
	});

	it('should return the correct wordmark', async function() {
		const response = await axios.get(url);
		assert.include(response.data, `${resources}/wordmark.svg`);
	});

	it('should return the correct icon', async function() {
		const response = await axios.get(url);
		assert.include(response.data, `${resources}/icon.svg`);
	});
});
