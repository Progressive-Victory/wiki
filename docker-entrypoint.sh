#!/bin/bash

until mysqladmin ping -hdb -uroot -p${DB_PASSWORD:-root} --silent; do
    echo "Waiting for MySQL to be ready..."
    sleep 2
done

chown www-data:www-data /var/www/html/LocalSettings.php
chmod 644 /var/www/html/LocalSettings.php

add-mw-extension 1.39 /var/www/html Nuke Scribunto \
    UploadWizard TitleKey TitleBlacklist TimedMediaHandler wikihiero Math \
    timeline Echo MobileFrontend Thanks VisualEditor Babel \
    GeoData RSS TorBlock ConfirmEdit cldr CleanChanges LocalisationUpdate \
    Translate UniversalLanguageSelector Widgets TemplateStyles \
    CiteThisPage ContentTranslation TemplateSandbox CodeEditor CodeMirror \
    CategoryTree CharInsert Kartographer LabeledSectionTransclusion Poem \
    Score VipsScaler GettingStarted PageImages AdvancedSearch \
    ArticleCreationWorkflow Disambiguator DismissableSiteNotice FileExporter \
    JsonConfig MultimediaViewer PageViewInfo SandboxLink TemplateWizard WikiLove \
    PagedTiffHandler TextExtracts PageAssessments Linter TemplateData \
    OATHAuth Cite Gadgets AbuseFilter ParserFunctions SyntaxHighlight_GeSHi SpamBlacklist InputBox PdfHandler WikiEditor ImageMap \
    CookieWarning

download-extension Lockdown https://extdist.wmflabs.org/dist/extensions/Lockdown-REL1_39-12dd618.tar.gz

# TODO: https://www.mediawiki.org/wiki/Special:ExtensionDistributor/YouTube - this isn't downloading
# download-extension Youtube https://extdist.wmflabs.org/dist/extensions/YouTube-REL1_39-28a05a9.tar.gz

apache2-foreground "$@"
