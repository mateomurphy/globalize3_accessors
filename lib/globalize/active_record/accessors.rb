module Globalize
  module ActiveRecord
    module Accessors
      extend ActiveSupport::Concern
    
      module ClassMethods
        def locale_accessors(*locales)
          translated_attribute_names.each do |attr_name|
            locales.each do |locale|
              define_method :"#{attr_name}_#{locale}" do
                read_attribute(attr_name, :locale => locale)
              end

              define_method :"#{attr_name}_#{locale}=" do |val|
                write_attribute(attr_name, val, :locale => locale)
              end
            end
          end
        end
      end
    end
  end
end