require 'rails_helper'

RSpec.describe User, type: :model do
  #Validation tests
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }

  # Association tests
  it { should have_many(:organizations).through(:user_organizations) }
  it { should have_many(:user_organizations)}
end
