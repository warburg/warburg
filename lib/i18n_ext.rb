module I18n
  class << self

    protected

    def default_exception_handler(exception, locale, key, options)
      if MissingTranslationData === exception
        MissingTranslation.find_or_create_by_key("#{locale}.#{key}")
        return exception.message
      end
      raise exception
    end

  end
end