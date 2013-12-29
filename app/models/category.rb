class Category < ActiveRecord::Base
  include Sluggable

  has_many :post_categories
  has_many :posts, through: :post_categories

  validates :category, presence: true, uniqueness: true

  sluggable_column :category
end