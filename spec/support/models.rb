class Post < ActiveRecord::Base
  translates :title, :content
  locale_accessors :en, :fr
end

class Comment < ActiveRecord::Base
  translates :body
  locale_accessors
end