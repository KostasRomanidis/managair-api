module Api::V1
 class OrganizationsController < ApplicationController
   before_action :set_organization, only: [:show, :update, :destroy, :add_user]

   def index
     render json: current_user.organizations
   end

   def create
     @organization = current_user.organizations.create!(organization_params)
     render json: @organization, status: :created
   end

   def show
     render json: @organization
   end

   def update
     @organization.update(organization_params)
     head :no_content
   end

   def destroy
     @organization.destroy
     head :no_content
   end

   def add_user
     find_user
     logger.debug @organization.id
     @user_organization = UserOrganization.new(user_id: @user.id, organization_id: @organization.id, role: 'Member')
     @user_organization.save
   end

   private
   def organization_params
     params.permit(:name)
   end

   def set_organization
     @organization = current_user.organizations.find(params[:id])
   end

   def find_user
     @user ||= User.find_by!(email: params[:email])
   rescue ActiveRecord::RecordNotFound => e
     raise(
       ExceptionHandler::UserNotFound,
        ("#{Message.user_not_found} #{e.message}")
      )
   end
 end
end
