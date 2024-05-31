#!/bin/bash

until mysqladmin ping -hdb -uroot -p${DB_PASSWORD:-root} --silent; do
    echo "Waiting for MySQL to be ready..."
    sleep 2
done

# Set the ServerName directive to suppress Apache warning
echo "ServerName localhost" >> /etc/apache2/apache2.conf

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
    PagedTiffHandler TextExtracts PageAssessments Linter TemplateData HTMLTags \
    OATHAuth Cite Gadgets AbuseFilter ParserFunctions SyntaxHighlight_GeSHi SpamBlacklist InputBox PdfHandler WikiEditor ImageMap \
    CookieWarning PluggableAuth WSOAuth CategoryLockdown

download-extension Lockdown REL1_39
download-extension TemplateSandbox REL1_39
download-extension UploadWizard REL1_39
download-extension TimedMediaHandler REL1_39
download-extension JsonConfig REL1_39
download-extension TemplateWizard REL1_39
download-extension YouTube REL1_39
download-extension CookieWarning REL1_39
download-extension DismissableSiteNotice REL1_39
download-extension VipsScaler REL1_39
download-extension ArticleCreationWorkflow REL1_39
download-extension PageViewInfo REL1_39
download-extension LocalisationUpdate REL1_39
download-extension SandboxLink REL1_39
download-extension CategoryLockdown REL1_39

# rm -rf /var/www/html/extensions/HTMLTags
# rm -rf /var/www/html/extensions/TemplateStyles
# rm -rf /var/www/html/extensions/LabeledSectionTransclusion
# rm -rf /var/www/html/extensions/RSS
# rm -rf /var/www/html/extensions/CharInsert
# rm -rf /var/www/html/extensions/wikihiero
# rm -rf /var/www/html/extensions/UniversalLanguageSelector
# rm -rf /var/www/html/extensions/LabeledSectionTransclusion

download-extension HTMLTags REL1_39
download-extension TemplateStyles REL1_39
download-extension RSS REL1_39
download-extension CharInsert REL1_39
download-extension wikihiero REL1_39
download-extension UniversalLanguageSelector REL1_39
download-extension LabeledSectionTransclusion REL1_39
# git clone  https://gerrit.wikimedia.org/r/mediawiki/extensions/HTMLTags.git /var/www/html/extensions/HTMLTags

# rm -rf /var/www/html/extensions/SimpleEmbed
git clone https://github.com/Le-onardo/SimpleEmbed.git /var/www/html/extensions/SimpleEmbed

# clone-extension LabeledSectionTransclusion https://gerrit.wikimedia.org/r/mediawiki/extensions/LabeledSectionTransclusion.git -b REL1_39
clone-extension Discord https://github.com/jayktaylor/mw-discord.git -b REL1_38
# clone-extension DiscordAuth https://github.com/shroomok/mediawiki-DiscordAuth.git
clone-extension EmbedVideo https://github.com/StarCitizenWiki/mediawiki-extensions-EmbedVideo.git
clone-extension Moderation https://github.com/edwardspec/mediawiki-moderation.git

for ext in HTMLTags; do
    if [ ! -f "/var/www/html/extensions/$ext/extension.json" ]; then
        echo "Error: /var/www/html/extensions/$ext/extension.json not found"
        exit 1
    fi
done

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
# chcon -t httpd_sys_script_exec_t /var/www/html/extensions/Scribunto/includes/engines/LuaStandalone/binaries/lua5_1_5_linux_64_generic/lua

echo "Finished preparing mediawiki!"

apache2-foreground "$@"
