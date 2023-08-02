#!/bin/bash

until mysqladmin ping -hdb -uroot -p${DB_PASSWORD:-root} --silent; do
    echo "Waiting for MySQL to be ready..."
    sleep 2
done

chown www-data:www-data /var/www/html/LocalSettings.php
chmod 644 /var/www/html/LocalSettings.php

add-mw-extension 1.39 /var/www/html Nuke Scribunto \
    TitleKey TitleBlacklist wikihiero Math \
    timeline Echo MobileFrontend Thanks VisualEditor Babel \
    GeoData RSS TorBlock ConfirmEdit cldr CleanChanges LocalisationUpdate \
    Translate UniversalLanguageSelector Widgets TemplateStyles \
    CiteThisPage ContentTranslation CodeEditor CodeMirror \
    CategoryTree CharInsert Kartographer LabeledSectionTransclusion Poem \
    Score VipsScaler GettingStarted PageImages AdvancedSearch \
    ArticleCreationWorkflow Disambiguator DismissableSiteNotice \
    MultimediaViewer PageViewInfo SandboxLink WikiLove \
    PagedTiffHandler TextExtracts PageAssessments Linter TemplateData \
    OATHAuth Cite Gadgets AbuseFilter ParserFunctions SyntaxHighlight_GeSHi SpamBlacklist InputBox PdfHandler WikiEditor ImageMap \
    CookieWarning PluggableAuth WSOAuth CategoryLockdown

download-extension Lockdown REL1_39
download-extension TemplateSandbox REL1_39
download-extension UploadWizard REL1_39
download-extension TimedMediaHandler REL1_39
download-extension JsonConfig REL1_39
download-extension TemplateWizard REL1_39
download-extension YouTube REL1_39

clone-extension LabeledSectionTransclusion https://gerrit.wikimedia.org/r/mediawiki/extensions/LabeledSectionTransclusion.git
clone-extension SimpleEmbed https://github.com/Le-onardo/SimpleEmbed.git
clone-extension HTMLTags https://gerrit.wikimedia.org/r/mediawiki/extensions/HTMLTags.git
clone-extension Discord https://github.com/jayktaylor/mw-discord.git -b REL1_38
# clone-extension DiscordAuth https://github.com/shroomok/mediawiki-DiscordAuth.git
clone-extension EmbedVideo https://github.com/StarCitizenWiki/mediawiki-extensions-EmbedVideo.git
clone-extension Moderation https://github.com/edwardspec/mediawiki-moderation.git

echo "Updating composer..."

rm -rf vendor/*
/usr/local/bin/composer clear-cache
#/usr/local/bin/composer require restcord/restcord
#/user/local/bin/composer require wohali/oauth2-discord-new
/usr/local/bin/composer update --with-all-dependencies --no-dev # Running composer install leads into "SiteConfig contains 1 abstract..." error

php /var/www/html/maintenance/update.php

chmod a+w /var/www/html/extensions/Widgets/compiled_templates/
chgrp www-data /var/www/html/extensions/Widgets/compiled_templates/

# $ getconf LONG_BIT
chmod a+x /var/www/html/extensions/Scribunto/includes/engines/LuaStandalone/binaries/lua5_1_5_linux_64_generic/lua
chcon -t httpd_sys_script_exec_t /var/www/html/extensions/Scribunto/includes/engines/LuaStandalone/binaries/lua5_1_5_linux_64_generic/lua

echo "Finished preparing mediawiki!"

apache2-foreground "$@"
