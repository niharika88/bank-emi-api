require 'rails_helper'

RSpec.describe Bank, type: :model do
	it { should have_one(:tenure).dependent(:destroy) }
	it { should validate_presence_of(:name) }
end
