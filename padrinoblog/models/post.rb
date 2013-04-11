class Post < ActiveRecord::Base
	has_many :post_tags
	has_many :tags, :through => :post_tags
	has_many :comments
	belongs_to :author
end
