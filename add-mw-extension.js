#!/usr/bin/env node

// Source: https://github.com/offspot/mediawiki-docker/blob/main/add-mw-extension.py

'use strict';

const { get } = require('https');
const { promises: fsPromises, createWriteStream } = require('fs');
const { promisify } = require('util');
const { exec } = require('child_process');

const execPromise = promisify(exec);

const EXTENSION_API = "https://www.mediawiki.org/w/api.php?action=query&list=extdistbranches&edbexts=%s&format=json";

let extension_version = "REL1_39";
let mediawiki_path = "/var/www/html";
const RETRY_LIMIT = 3;
const CONCURRENT_TASKS_LIMIT = 5;

if (process.argv.length > 2) {
	extension_version = process.argv[2];
}
else {
	console.log("extension version needed");
	process.exit(1);
}

if (process.argv.length > 3) {
	mediawiki_path = process.argv[3];
}
else {
	console.log("media wiki path needed");
	process.exit(1);
}

if (process.argv.length <= 4) {
	console.log("extension name needed");
	process.exit(1);
}

const getExistingExtensions = async () => {
	let directories;
	try {
		directories = await fsPromises.readdir(`${mediawiki_path}/extensions`, { withFileTypes: true });
	}
	catch (err) {
		console.error('Error reading extensions directory', err);
		return [];
	}
	return directories.filter(dir => dir.isDirectory()).map(dir => dir.name);
};

const getJSON = async (url) => {
	return new Promise((resolve, reject) => {
		get(url, (res) => {
			let data = '';
			res.on('data', (chunk) => {
				data += chunk;
			});
			res.on('end', () => resolve(JSON.parse(data)));
		}).on('error', reject);
	});
};

const downloadFile = async (url, path, retryCount = 0) => {
	try {
		const writer = createWriteStream(path);
		await new Promise((resolve, reject) => {
			const request = get(url, (response) => {
				response.pipe(writer);
				writer.on('finish', resolve);
				writer.on('error', reject);
			});
			request.on('error', reject);
		});
	}
	catch(err) {
		if (retryCount < RETRY_LIMIT) {
			console.log(`[${url}] Retry downloading...${retryCount + 1}`);
			await downloadFile(url, path, retryCount + 1);
		}
		else {
			throw err;
		}
	}
};

(async () => {
	async function task(extension_name) {
		let retryCount = 0;
		while (retryCount < RETRY_LIMIT) {
			try {
				const downloadPath = EXTENSION_API.replace('%s', extension_name);
				console.log(`[${extension_name}] Get information on the extension - ${downloadPath}`);
				const data = await getJSON(downloadPath);
				if ("extensions" in data.query.extdistbranches) {
					let url;
					if (extension_version in data.query.extdistbranches.extensions[extension_name]) {
						url = data.query.extdistbranches.extensions[extension_name][extension_version];
					}
					else {
						url = data.query.extdistbranches.extensions[extension_name].master;
					}

					console.log(`[${extension_name}] Download extension`);
					const filename = `/tmp/${extension_name}.tgz`;
					await downloadFile(url, filename);

					console.log(`[${extension_name}] Extract files`);
					const tarExtractResult = await execPromise(`tar -xf ${filename} -C ${mediawiki_path}/extensions`);
					if (tarExtractResult.error) {
						console.error('Error to extract extension tarball', tarExtractResult.error);
						process.exit(4);
					}
					
					await fsPromises.unlink(filename);
					console.log(`[${extension_name}] Extension installed`)
					
					break;
				}
				else {
					console.log(`Extension ${extension_name} not found`);
					process.exit(1);
				}
			}
			catch (err) {
				console.error(`Error fetching extension url ${err.message}`);
				if (retryCount < RETRY_LIMIT - 1) {
					console.log(`[${extension_name}] Retry ${retryCount + 1}`);
					retryCount++;
				}
				else {
					process.exit(2);
				}
			}
		}
	}

	const existingExtensions = await getExistingExtensions();
	const extensionNames = process.argv.slice(4).filter(extension => !existingExtensions.includes(extension));

	console.log(`Installing extensions: ${extensionNames.join(', ')}`);

	const chunks = Array(Math.ceil(extensionNames.length / CONCURRENT_TASKS_LIMIT))
		.fill()
		.map((_, index) => index * CONCURRENT_TASKS_LIMIT)
		.map(begin => extensionNames.slice(begin, begin + CONCURRENT_TASKS_LIMIT));
	
	for (const chunk of chunks) {
		const tasks = chunk.map(extension_name => task(extension_name));
		await Promise.all(tasks);
	}

	console.log(`${extensionNames.length} extensions installed`);
})();
