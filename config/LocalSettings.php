<?php
# This file was automatically generated by the MediaWiki 1.39.3
# installer. If you make manual changes, please keep track in case you
# need to recreate them later.
#
# See docs/Configuration.md for all configurable settings
# and their default values, but don't forget to make changes in _this_
# file, not there.
#
# Further documentation for configuration settings may be found at:
# https://www.mediawiki.org/wiki/Manual:Configuration_settings

# Protect against web entry
if ( !defined( 'MEDIAWIKI' ) ) {
	exit;
}


## Uncomment this to disable output compression
# $wgDisableOutputCompression = true;

$wgSitename = getenv('MW_SITE_NAME') ?? "Progressive Victory Wiki";
$wgMetaNamespace = getenv('MW_META_NAMESPACE') ?? "Progressive_Victory_Wiki";

## The URL base path to the directory containing the wiki;
## defaults for all runtime URL paths are based off of this.
## For more information on customizing the URLs
## (like /w/index.php/Page_title to /wiki/Page_title) please see:
## https://www.mediawiki.org/wiki/Manual:Short_URL
$wgScriptPath = "";

## The protocol and server name to use in fully-qualified URLs
$wgServer = getenv('MW_SITE_SERVER') ?? "https://localhost";

## The URL path to static resources (images, scripts, etc.)
$wgResourceBasePath = $wgScriptPath;

## The URL paths to the logo.  Make sure you change this from the default,
## or else you'll overwrite your logo when you upgrade!
$wgLogos = [
	'1x' => "$wgResourceBasePath/resources/assets/images/logo.svg",
	'wordmark' => [
		"src" => "$wgResourceBasePath/resources/assets/images/wordmark.svg",
		"width" => 119,
		"height" => 18,
	],
	'icon' => "$wgResourceBasePath/resources/assets/images/icon.svg",
];

## UPO means: this is also a user preference option

$wgEnableEmail = false;
$wgEnableUserEmail = true; # UPO

$wgEmergencyContact = "";
$wgPasswordSender = "";

$wgEnotifUserTalk = false; # UPO
$wgEnotifWatchlist = false; # UPO
$wgEmailAuthentication = true;

## Database settings
$wgDBtype = "mysql";
$wgDBserver = getenv('DB_SERVER') ?? "db";
$wgDBname = getenv('DB_NAME') ?? "my_wiki";
$wgDBuser = getenv('DB_USER') ?? "root";
$wgDBpassword = getenv('DB_PASSWORD') ?? "root";

# MySQL specific settings
$wgDBprefix = "";

# MySQL table options to use during installation or update
$wgDBTableOptions = "ENGINE=InnoDB, DEFAULT CHARSET=binary";

# Shared database table
# This has no effect unless $wgSharedDB is also set.
$wgSharedTables[] = "actor";

## Shared memory settings
$wgMainCacheType = CACHE_ACCEL;
$wgMemCachedServers = [];

## To enable image uploads, make sure the 'images' directory
## is writable, then set this to true:
$wgEnableUploads = true;
$wgUseImageMagick = true;
$wgImageMagickConvertCommand = "/usr/bin/convert";

# InstantCommons allows wiki to use images from https://commons.wikimedia.org
$wgUseInstantCommons = true;

# Periodically send a pingback to https://www.mediawiki.org/ with basic data
# about this MediaWiki instance. The Wikimedia Foundation shares this data
# with MediaWiki developers to help guide future development efforts.
$wgPingback = true;

# Site language code, should be one of the list in ./includes/languages/data/Names.php
$wgLanguageCode = "en-gb";

# Time zone
$wgLocaltimezone = "UTC";

## Set $wgCacheDirectory to a writable directory on the web server
## to make your wiki go slightly faster. The directory should not
## be publicly accessible from the web.
#$wgCacheDirectory = "$IP/cache";

$wgSecretKey = "6a01961246c6ba43e33b28d89ef458b36f7bbaca4e2aa9cebde2e3d6dffd8166";

# Changing this will log out all existing sessions.
$wgAuthenticationTokenVersion = "1";

# Site upgrade key. Must be set to a string (default provided) to turn on the
# web installer while LocalSettings.php is in place
$wgUpgradeKey = "414b8568566b3d5f";

## For attaching licensing metadata to pages, and displaying an
## appropriate copyright notice / icon. GNU Free Documentation
## License and Creative Commons licenses are supported so far.
$wgRightsPage = ""; # Set to the title of a wiki page that describes your license/copyright
$wgRightsUrl = "https://creativecommons.org/licenses/by-sa/4.0/";
$wgRightsText = "Creative Commons Attribution-ShareAlike";
$wgRightsIcon = "$wgResourceBasePath/resources/assets/licenses/ccheart.svg";

# Path to the GNU diff3 utility. Used for conflict resolution.
$wgDiff3 = "/usr/bin/diff3";

## Default skin: you can change the default skin. Use the internal symbolic
## names, e.g. 'vector' or 'monobook':
$wgDefaultSkin = "vector";

# Enabled skins.
# The following skins were automatically enabled:
wfLoadSkin( 'MinervaNeue' );
wfLoadSkin( 'MonoBook' );
wfLoadSkin( 'Timeless' );
wfLoadSkin( 'Vector' );


# Enabled extensions. Most of the extensions are enabled by adding
# wfLoadExtension( 'ExtensionName' );
# to LocalSettings.php. Check specific extension documentation for more details.
# The following extensions were automatically enabled:
wfLoadExtension( 'AbuseFilter' );
wfLoadExtension( 'CategoryTree' );
wfLoadExtension( 'Cite' );
wfLoadExtension( 'CiteThisPage' );
wfLoadExtension( 'CodeEditor' );
wfLoadExtension( 'ConfirmEdit' );
wfLoadExtension( 'Gadgets' );
wfLoadExtension( 'ImageMap' );
wfLoadExtension( 'InputBox' );
wfLoadExtension( 'Interwiki' );
wfLoadExtension( 'Math' );
wfLoadExtension( 'MultimediaViewer' );
wfLoadExtension( 'Nuke' );
wfLoadExtension( 'OATHAuth' );
wfLoadExtension( 'PageImages' );
wfLoadExtension( 'ParserFunctions' );
wfLoadExtension( 'PdfHandler' );
wfLoadExtension( 'Poem' );
wfLoadExtension( 'Renameuser' );
wfLoadExtension( 'ReplaceText' );
wfLoadExtension( 'Scribunto' );
wfLoadExtension( 'SecureLinkFixer' );
wfLoadExtension( 'SpamBlacklist' );
wfLoadExtension( 'SyntaxHighlight_GeSHi' );
wfLoadExtension( 'TemplateData' );
wfLoadExtension( 'TextExtracts' );
wfLoadExtension( 'TitleBlacklist' );
wfLoadExtension( 'VisualEditor' );
wfLoadExtension( 'WikiEditor' );

# wfLoadExtension( 'UploadWizard' );
wfLoadExtension( 'TitleKey' );
wfLoadExtension( 'TitleBlacklist' );
# wfLoadExtension( 'TimedMediaHandler' );
#wfLoadExtension( 'wikihiero' );
wfLoadExtension( 'Math' );
# wfLoadExtension( 'timeline' );
# wfLoadExtension( 'Echo' );
# wfLoadExtension( 'MobileFrontend' );
# wfLoadExtension( 'Thanks' );
#wfLoadExtension( 'Babel' );
# wfLoadExtension( 'GeoData' );
#wfLoadExtension( 'RSS' );
#wfLoadExtension( 'TorBlock' );
#wfLoadExtension( 'ConfirmEdit' );
#wfLoadExtension( 'cldr' );
#wfLoadExtension( 'CleanChanges' );
#wfLoadExtension( 'LocalisationUpdate' );
#wfLoadExtension( 'Translate' );
#wfLoadExtension( 'UniversalLanguageSelector' );
#wfLoadExtension( 'Widgets' );
#wfLoadExtension( 'TemplateStyles' );
#wfLoadExtension( 'CiteThisPage' );
# wfLoadExtension( 'ContentTranslation' );
# wfLoadExtension( 'TemplateSandbox' );
#wfLoadExtension( 'CodeEditor' );
# wfLoadExtension( 'CodeMirror' );
#wfLoadExtension( 'CategoryTree' );
#wfLoadExtension( 'CharInsert' );
# wfLoadExtension( 'Kartographer' );
#wfLoadExtension( 'LabeledSectionTransclusion' );
#wfLoadExtension( 'Poem' );
# wfLoadExtension( 'Score' );
#wfLoadExtension( 'VipsScaler' );
#wfLoadExtension( 'GettingStarted' );
wfLoadExtension( 'PageImages' );
# wfLoadExtension( 'AdvancedSearch' );
#wfLoadExtension( 'ArticleCreationWorkflow' );
# wfLoadExtension( 'Disambiguator' );
#wfLoadExtension( 'DismissableSiteNotice' );
#wfLoadExtension( 'FileExporter' );
# wfLoadExtension( 'JsonConfig' );
#wfLoadExtension( 'MultimediaViewer' );
#wfLoadExtension( 'PageViewInfo' );
#fLoadExtension( 'SandboxLink' );
# wfLoadExtension( 'TemplateWizard' );
#wfLoadExtension( 'WikiLove' );

# Required for MVP
wfLoadExtension( 'Lockdown' );
# wfLoadExtension( 'Youtube' );
wfLoadExtension( 'CookieWarning' );

# End of automatically generated settings.
# Add more configuration options below.

# Load extra settings
require 'ExtraLocalSettings.php';
