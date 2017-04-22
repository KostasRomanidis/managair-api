require 'rails_helper'

RSpec.describe Organization, type: :model do
  it { should have_many(:customers)}
  it { should have_many(:products)}
  # Validation Tests
  it { should validate_presence_of(:name) }
end
