require 'rails_helper'

RSpec.describe Tenure, type: :model do
  it { should belong_to(:bank) }
  it { should validate_presence_of(:month) }
  it { should validate_presence_of(:rate) }
  it { should validate_presence_of(:minimum_amount) }
  it { should validate_presence_of(:bank_id) }
end
