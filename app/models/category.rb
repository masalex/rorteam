# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Category < ActiveRecord::Base
  has_many :post_categories ,:dependent => :destroy
  has_many :posts, through: :post_categories

  validates :name, :presence => true
  validates :name, :uniqueness => true

end
