class Tenure < ApplicationRecord

  # model association
  belongs_to :bank


  # validation
  validates_presence_of :month
  validates_presence_of :rate
  validates_presence_of :minimum_amount
  validates_presence_of :bank_id
end
