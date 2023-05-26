<?php

// @see https://www.mediawiki.org/wiki/Manual:Configuration_settings

# Protect against web entry
if ( !defined( 'MEDIAWIKI' ) ) {
    exit;
}

$wgGroupPermissions['*']['createaccount'] = true;
$wgGroupPermissions['*']['edit'] = false;
$wgGroupPermissions['*']['read'] = true;

$wgNamespacePermissionLockdown[NS_USER]['*'] = ['sysop'];
$wgNamespacePermissionLockdown[NS_USER]['read'] = ['*'];
$wgNamespacePermissionLockdown[NS_USER_TALK]['*'] = ['sysop'];
$wgNamespacePermissionLockdown[NS_USER_TALK]['read'] = ['*'];

## Uncomment this to disable output compression
# $wgDisableOutputCompression = true;

// OPTIONAL: Enable VisualEditor's experimental code features
#$wgDefaultUserOptions['visualeditor-enable-experimental'] = 1;

# $wgShowExceptionDetails = true;
$wgFavicon = "$wgResourceBasePath/resources/assets/images/favicon.ico";
$wgStylePath = "$wgResourceBasePath/assets/styles/index.css";
