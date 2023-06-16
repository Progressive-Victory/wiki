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
    ArticleCreationWorkflow Disambiguator DismissableSiteNotice FileExporter \
    MultimediaViewer PageViewInfo SandboxLink WikiLove \
    PagedTiffHandler TextExtracts PageAssessments Linter TemplateData \
    OATHAuth Cite Gadgets AbuseFilter ParserFunctions SyntaxHighlight_GeSHi SpamBlacklist InputBox PdfHandler WikiEditor ImageMap \
    CookieWarning

download-extension Lockdown REL1_39
download-extension TemplateSandbox REL1_39
download-extension UploadWizard REL1_39
download-extension TimedMediaHandler REL1_39
download-extension JsonConfig REL1_39
download-extension TemplateWizard REL1_39

if [ ! -d "/var/www/html/extensions/LabeledSectionTransclusion" ]; then
    git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/LabeledSectionTransclusion.git /var/www/html/extensions/LabeledSectionTransclusion
fi

if [ ! -d "/var/www/html/extensions/SimpleEmbed" ]; then
    git clone https://github.com/Le-onardo/SimpleEmbed.git /var/www/html/extensions/SimpleEmbed
fi

if [ ! -d "/var/www/html/extensions/HTMLTags" ]; then
    git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/HTMLTags.git /var/www/html/extensions/HTMLTags
fi

# TODO: https://www.mediawiki.org/wiki/Special:ExtensionDistributor/YouTube - this isn't downloading
# download-extension Youtube https://extdist.wmflabs.org/dist/extensions/YouTube-REL1_39-28a05a9.tar.gz

echo "Updating composer..."

rm -rf vendor/*
COMPOSER=composer.local.json /usr/local/bin/composer clear-cache
COMPOSER=composer.local.json /usr/local/bin/composer update && COMPOSER=composer.local.json /usr/local/bin/composer install

echo "Finished preparing mediawiki!"

apache2-foreground "$@"
