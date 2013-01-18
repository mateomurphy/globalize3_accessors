module Globalize
  module ActiveRecord
    module Accessors
      extend ActiveSupport::Concern
    
      module ClassMethods
        # Implement localized accessors for all translated attributes. 
        # if locales are passed, only those locales will have accessors.
        # otherwise, accessors for all locales will be created dynamically.
        def locale_accessors(*locales)
          
          include DynamicAccessors unless locales.any?
          
          translated_attribute_names.each do |attr_name|
            locales.each do |locale|
              define_localized_accessor(attr_name, locale)
            end
          end
        end

        # Define a set of accessors for the given attribute and locale
        def define_localized_accessor(attr_name, locale)
          define_method :"#{attr_name}_#{locale}" do
            Globalize.with_locale(locale) do
              send attr_name
            end
            #read_attribute(attr_name, :locale => locale)
          end

          define_method :"#{attr_name}_#{locale}=" do |val|
            Globalize.with_locale(locale) do
              send :"#{attr_name}=", val
            end
            #write_attribute(attr_name, val, :locale => locale)
          end          
        end
      end

      module DynamicAccessors
        
        # Defines accessors dynamically as needed
        class Matcher
          attr_accessor :attribute, :locale, :instance
          def initialize(method_sym, instance)
            @instance = instance
            
            if method_sym.to_s =~ /^(\w*)_(\w\w)(=)?$/
              @attribute = $1.to_sym
              @locale = $2.to_sym
            end
          end
  
          def exists?
            instance.respond_to?(attribute)
          end

          def translated?
            instance.translated?(attribute)
          end
  
          def match?
            @attribute != nil && exists?
          end
          
          def define
            match? and instance.class.define_localized_accessor(attribute, locale)
          end
        end
        
        def method_missing(name, *args)
          if Matcher.new(name, self).define
            send(name, *args)
          else
            super
          end
        end

        def respond_to_missing?(name, include_private = false)
          if Matcher.new(name, self).define
            return true
          else
            super
          end
        end
      end
    end
  end
end