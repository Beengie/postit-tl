class User < ActiveRecord::Base
  include Sluggable

  has_secure_password validations: false
  has_many :posts
  has_many :comments
  has_many :votes

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 5}

  sluggable_column :username
end