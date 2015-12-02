class Calendar < ActiveRecord::Base
  belongs_to :pocket
  belongs_to :user

  validates_presence_of :period
  validates_presence_of :sum_income
  validates_presence_of :sum_outgoing
  validates_presence_of :balance
  validates_presence_of :pocket_id
  validates_presence_of :user_id
end
