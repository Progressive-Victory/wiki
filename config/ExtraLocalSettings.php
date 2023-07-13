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

$wgShowExceptionDetails = true;

$wgFavicon = "$wgResourceBasePath/resources/assets/images/favicon.ico";
$wgStylePath = "$wgResourceBasePath/assets/styles/index.css";

$wgFooterIcons = [
	"copyright" => [
		"copyright" => [],
	],
	"poweredby" => [
		"mediawiki" => [
			"src" => "$wgResourceBasePath/resources/assets/images/mediawiki.svg",
			"url" => "https://www.mediawiki.org/",
			"alt" => "Powered by MediaWiki",
		]
	],
];

# Enable Bootstrap by default on all styles
$wgHooks['SetupAfterCache'][] = function(){
	\Bootstrap\BootstrapManager::getInstance()->addAllBootstrapModules();
	return true;
};

$wgHooks['ParserAfterParse'][]=function( Parser &$parser, &$text, StripState &$stripState ){
	$parser->getOutput()->addModuleStyles( ['ext.bootstrap.styles'] );
	$parser->getOutput()->addModules( ['ext.bootstrap.scripts'] );
	return true;
};

# $wgAllowExternalImages = true;
# $wgAllowImageTag = , 'style, 'style''tru, 'style'e;, , 'style''styl, 'style', 'style'e'

# HTMLTag Configuration
$wgHTMLTagsAttributes['a'] = [ 'href', 'class', 'style' ];
$wgHTMLTagsAttributes['p'] = [ 'class', 'style' ];
$wgHTMLTagsAttributes['div'] = [ 'class', 'style' ];
$wgHTMLTagsAttributes['span'] = [ 'class', 'style' ];
$wgHTMLTagsAttributes['h1'] = [ 'class', 'style' ];
$wgHTMLTagsAttributes['h2'] = [ 'class', 'style' ];
$wgHTMLTagsAttributes['h3'] = [ 'class', 'style' ];
$wgHTMLTagsAttributes['h4'] = [ 'class', 'style' ];
$wgHTMLTagsAttributes['h5'] = [ 'class', 'style' ];
$wgHTMLTagsAttributes['h6'] = [ 'class', 'style' ];
$wgHTMLTagsAttributes['img'] = [ 'src', 'class', 'style' ];
$wgHTMLTagsAttributes['ul'] = [ 'class', 'style' ];
$wgHTMLTagsAttributes['ol'] = [ 'class', 'style' ];
$wgHTMLTagsAttributes['li'] = [ 'class', 'style' ];
$wgHTMLTagsAttributes['table'] = [ 'class', 'style' ];
$wgHTMLTagsAttributes['tr'] = [ 'class', 'style' ];
$wgHTMLTagsAttributes['td'] = [ 'class', 'style' ];
$wgHTMLTagsAttributes['th'] = [ 'class', 'style' ];
$wgHTMLTagsAttributes['thead'] = [ 'class', 'style' ];
$wgHTMLTagsAttributes['tbody'] = [ 'class', 'style' ];
$wgHTMLTagsAttributes['tfoot'] = [ 'class', 'style' ];
$wgHTMLTagsAttributes['pre'] = [ 'class', 'style' ];
$wgHTMLTagsAttributes['code'] = [ 'class', 'style' ];
$wgHTMLTagsAttributes['footer'] = [ 'class', 'style' ];
$wgHTMLTagsAttributes['header'] = [ 'class', 'style' ];
$wgHTMLTagsAttributes['nav'] = [ 'class', 'style' ];
$wgHTMLTagsAttributes['section'] = [ 'class', 'style' ];
$wgHTMLTagsAttributes['style'] = [ ];

$wgAllowExternalImagesFrom = ['https://i.ytimg', 'https://scontent-hou1-1.cdninstagram.com'];
$wgAllowExternalImages = true;

$wgDiscordWebhookURL = [ getenv('DISCORD_UPDATE_HOOK') ?? '' ];

/*
$wgOAuthCustomAuthProviders = ['discord' => \DiscordAuth\AuthenticationProvider\DiscordAuth::class];
$wgPluggableAuth_EnableLocalLogin = true;
$wgPluggableAuth_Config['discordauth'] = [
    'plugin' => 'WSOAuth',
    'data' => [
        'type' => 'discord',
        'uri' => 'https://discord.com/oauth2/authorize',
        'clientId' => getenv('DISCORD_CLIENT_ID'),
        'clientSecret' => getenv('DISCORD_CLIENT_SECRET'),
        'redirectUri' => "$wgServer/index.php?title=Special:PluggableAuthLogin"
    ],
    'buttonLabelMessage' => 'discordauth-login-button-label'
];

$wgDiscordAuthBotToken = getenv('DISCORD_BOT_TOKEN');
$wgDiscordGuildId = getenv('DISCORD_GUILD_ID');
# $wgDiscordApprovedRoles = ['<role>']; // Only users with the specified roles will be able to login
*/

$wgUserrightsInterwikiDelimiter = '@';
$wgGroupPermissions['bureaucrat']['userrights-interwiki'] = true;
