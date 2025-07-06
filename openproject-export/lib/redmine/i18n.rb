module Redmine
  module I18n
    def l(key, **options)
      ::I18n.t(key, **options)
    end

    def current_language
      ::I18n.locale
    end

    def self.included(base)
      base.extend self
    end
  end
end
