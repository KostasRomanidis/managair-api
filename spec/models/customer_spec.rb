require 'rails_helper'

RSpec.describe Customer, type: :model do
  # validation tests
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:customer_type) }
end
