class UserOrganization < ApplicationRecord
  belongs_to :user
  belongs_to :organization
  validates_presence_of :user_id
  validates_presence_of :organization_id

  before_create :set_role_to_admin
  skip_callback :create, :before, :set_role_to_admin, if: -> { self.role == 'Member' }

  private
  def set_role_to_admin
    self.role = 'Admin'
  end
end
