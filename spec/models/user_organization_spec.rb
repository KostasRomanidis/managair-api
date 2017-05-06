require 'rails_helper'

RSpec.describe UserOrganization, type: :model do
  # association test
  it { should belong_to(:user)}
  it { should belong_to(:organization)}
  # validation tests
  it { should validate_presence_of(:user_id)}
  it { should validate_presence_of(:organization_id)}
  # callback method
  it { is_expected.to callback(:set_role_to_admin).before(:create) }
end
