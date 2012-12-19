ActiveRecord::Migration.verbose = false

ActiveRecord::Schema.define do
  create_table :comments, :force => true do |t|
    t.boolean    :published
  end

  create_table :comment_translations, :force => true do |t|
    t.string     :locale
    t.references :comment
    t.text       :body
    t.boolean    :published
    t.datetime   :published_at
  end  
  
  create_table :posts, :force => true do |t|
    t.boolean    :published
  end

  create_table :post_translations, :force => true do |t|
    t.string     :locale
    t.references :post
    t.string     :title
    t.text       :content
    t.boolean    :published
    t.datetime   :published_at
  end
end