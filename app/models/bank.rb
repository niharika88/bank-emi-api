class Bank < ApplicationRecord
	# model association
	has_one :tenure, dependent: :destroy

  # validations
  validates_presence_of :name
end
