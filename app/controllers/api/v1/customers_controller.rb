module Api::V1
  class CustomersController < ApplicationController
    before_action :set_organization
    before_action :set_customer, only: [:show, :update, :destroy]

    def index
      render json: @organization.customers, include: ['purchase']
    end

    def show
      render json: @customer
    end

    def create
      @customer = @organization.customers.create!(customer_params)
      render json: @customer, status: :created
    end

    def update
      @customer.update(customer_params)
      head :no_content
    end

    def destroy
      @customer.destroy
      head :no_content
    end

    private
    def customer_params
      params.permit(:name, :phone, :address, :customer_type, :organization_id)
    end

    def set_organization
      @organization = Organization.find(params[:organization_id])
    end

    def set_customer
      @customer = @organization.customers.find_by!(id: params[:id]) if @organization
    end
  end
end
