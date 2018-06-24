class Category < ApplicationRecord
	has_many :lots

	scope :type, ->(id){where('id = ?', id)}
end
