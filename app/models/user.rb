class User < ActiveRecord::Base
	has_many :pockets, dependent: :destroy
	has_many :calendars, dependent: :destroy
	has_many :categories, dependent: :destroy
	has_many :incomes, dependent: :destroy
	has_many :outgoings, dependent: :destroy

	validates_presence_of :name
end
