#!/usr/bin/env ruby

require 'yaml'

def load(lang)
  YAML::load_file(File.dirname(__FILE__) + "/../config/locales/#{lang}.yml")  
end

nl = load("nl")
en = load("en")
fr = load("fr")

def compare(nl, en, current_key)
  nl.each do |key, value|
    if en[key]
      if value.is_a?(Hash)
        compare(value, en[key], current_key + '.' + key)
      end
    else
      puts current_key + '.' + key
    end
    
  end
end

compare(nl['nl'], en['en'], 'en')
compare(nl['nl'], fr['fr'], 'fr')