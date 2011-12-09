class Post < ActiveRecord::Base
  translates :title, :content
  locale_accessors :en, :fr
end