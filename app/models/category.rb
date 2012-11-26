class Category < ActiveRecord::Base
  has_many :pages
  attr_accessible :name, :page_ids
  validates :name, presence: true
end
