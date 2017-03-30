require 'rails_helper'

RSpec.describe Purchase, type: :model do
  it { should validate_presence_of(:purchase_date)}
  it { should belong_to(:product)}
  it { should belong_to(:customer)}
end
