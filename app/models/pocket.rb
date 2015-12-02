class Pocket < ActiveRecord::Base
  belongs_to :user
  has_many :calendars, dependent: :destroy
  has_many :incomes, dependent: :destroy
  has_many :outgoings, dependent: :destroy

  validates_presence_of :name
  validates_presence_of :user_id
end
