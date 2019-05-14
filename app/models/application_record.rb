class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  config.i18n.available_locales = [:en]
end
