require 'rails_helper'

RSpec.describe Organization, type: :model do
  it { should have_many(:customers)}
  it { should have_many(:products)}
  it { should have_many(:purchases)}
  it { should have_many(:users).through(:user_organizations)}
  it { should have_many(:user_organizations)}
  # Validation Tests
  it { should validate_presence_of(:name) }
end
