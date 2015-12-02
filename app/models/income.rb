class Income < ActiveRecord::Base
  belongs_to :category
  belongs_to :pocket
  belongs_to :user

  validates_presence_of :date
  validates_presence_of :sum
  validates_presence_of :category_id
  validates_presence_of :pocket_id
  validates_presence_of :user_id
end
