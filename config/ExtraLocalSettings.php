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
# $wgAllowImageTag = true;

# HTMLTag Configuration
$wgHTMLTagsAttributes['a'] = [ 'href', 'class' ];
$wgHTMLTagsAttributes['p'] = [ 'class' ];
$wgHTMLTagsAttributes['div'] = [ 'class' ];
$wgHTMLTagsAttributes['span'] = [ 'class' ];
$wgHTMLTagsAttributes['h1'] = [ 'class' ];
$wgHTMLTagsAttributes['h2'] = [ 'class' ];
$wgHTMLTagsAttributes['h3'] = [ 'class' ];
$wgHTMLTagsAttributes['h4'] = [ 'class' ];
$wgHTMLTagsAttributes['h5'] = [ 'class' ];
$wgHTMLTagsAttributes['h6'] = [ 'class' ];
$wgHTMLTagsAttributes['img'] = [ 'src', 'class' ];
$wgHTMLTagsAttributes['ul'] = [ 'class' ];
$wgHTMLTagsAttributes['ol'] = [ 'class' ];
$wgHTMLTagsAttributes['li'] = [ 'class' ];
$wgHTMLTagsAttributes['table'] = [ 'class' ];
$wgHTMLTagsAttributes['tr'] = [ 'class' ];
$wgHTMLTagsAttributes['td'] = [ 'class' ];
$wgHTMLTagsAttributes['th'] = [ 'class' ];
$wgHTMLTagsAttributes['thead'] = [ 'class' ];
$wgHTMLTagsAttributes['tbody'] = [ 'class' ];
$wgHTMLTagsAttributes['tfoot'] = [ 'class' ];
$wgHTMLTagsAttributes['pre'] = [ 'class' ];
$wgHTMLTagsAttributes['code'] = [ 'class' ];
$wgHTMLTagsAttributes['footer'] = [ 'class' ];
$wgHTMLTagsAttributes['header'] = [ 'class' ];
$wgHTMLTagsAttributes['nav'] = [ 'class' ];
$wgHTMLTagsAttributes['section'] = [ 'class' ];
$wgHTMLTagsAttributes['style'] = [ ];

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
