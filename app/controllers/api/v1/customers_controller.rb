module Api::V1
  class CustomersController < ApplicationController
    before_action :set_customer, only: [:show, :update, :destroy]

    def index
      render json: Customer.all, include: ['purchase']
    end

    def show
      render json: @customer
    end

    def create
      @customer = Customer.create!(customer_params)
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
      params.permit(:name, :phone, :address, :customer_type)
    end

    def set_customer
      @customer = Customer.find(params[:id])
    end
  end
end
