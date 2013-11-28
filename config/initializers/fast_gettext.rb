FastGettext.default_available_locales = ['en','ro']
FastGettext.default_text_domain = 'app'
FastGettext.add_text_domain 'app', :path => 'locale'

# Trust all usages of '%' in translations
GettextI18nRails.translations_are_html_safe = true
