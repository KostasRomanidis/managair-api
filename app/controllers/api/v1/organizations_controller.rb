module Api::V1
 class OrganizationsController < ApplicationController
   before_action :set_organization, only: [:show, :update, :destroy]

   def index
     render json: Organization.all
   end

   def create
     @organization = Organization.create!(organization_params)
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

   private
   def organization_params
     params.permit(:name)
   end

   def set_organization
     @organization = Organization.find(params[:id])
   end
 end
end
