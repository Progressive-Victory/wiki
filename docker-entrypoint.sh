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

download-extension Lockdown https://extdist.wmflabs.org/dist/extensions/Lockdown-REL1_39-12dd618.tar.gz
download-extension TemplateSandbox https://extdist.wmflabs.org/dist/extensions/TemplateSandbox-REL1_39-ffbcd7f.tar.gz
download-extension UploadWizard https://extdist.wmflabs.org/dist/extensions/UploadWizard-REL1_39-4f5053f.tar.gz
download-extension TimedMediaHandler https://extdist.wmflabs.org/dist/extensions/TimedMediaHandler-REL1_39-54b0d2c.tar.gz
download-extension JsonConfig https://extdist.wmflabs.org/dist/extensions/JsonConfig-REL1_39-c80430f.tar.gz
download-extension TemplateWizard https://extdist.wmflabs.org/dist/extensions/TemplateWizard-REL1_39-c41edbf.tar.gz

if [ ! -d "/var/www/html/extensions/LabeledSectionTransclusion" ]; then
    git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/LabeledSectionTransclusion.git /var/www/html/extensions/LabeledSectionTransclusion
fi

if [ ! -d "/var/www/html/extensions/SimpleEmbed" ]; then
    git clone https://github.com/Le-onardo/SimpleEmbed.git /var/www/html/extensions/SimpleEmbed
fi

# TODO: https://www.mediawiki.org/wiki/Special:ExtensionDistributor/YouTube - this isn't downloading
# download-extension Youtube https://extdist.wmflabs.org/dist/extensions/YouTube-REL1_39-28a05a9.tar.gz

apache2-foreground "$@"
