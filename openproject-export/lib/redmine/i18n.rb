module Redmine
  module I18n
    def l(_key, default: nil, **_options)
      default || _key.to_s
    end

    def current_language
      :en
    end
    def self.included(base)
      base.extend self
    end
  end
end
