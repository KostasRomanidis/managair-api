require 'rails_helper'

RSpec.describe Product, type: :model do
  it { should belong_to(:organization)}
  # Validation Tests
  it { should validate_presence_of(:brand) }
  it { should validate_presence_of(:model) }
  it { should validate_presence_of(:btu) }
  it { should validate_presence_of(:cost) }
end
