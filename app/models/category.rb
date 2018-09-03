class Category < ApplicationRecord
	has_many :lots

	validates :title, presence: true

	scope :type, ->(id){where('id = ?', id)}
	scope :alpha, ->{order( title: :asc)}
end
