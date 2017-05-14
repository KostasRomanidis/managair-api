module Api::V1
  class PurchasesController < ApplicationController
    before_action :set_organization
    before_action :set_customer, only: [:index, :create, :show, :destroy, :update]

    def index
      render json: @customer.purchases
    end

    def create
      @purchase = @customer.purchases.create!(purchase_params)
      render json: @purchase, status: :created
    end

    def show
      @purchase = @customer.purchases.find(params[:id])
      render json: @purchase
    end

    def update
      @purchase = @customer.purchases.find(params[:id])
      @purchase.update(purchase_params)
      head :no_content
    end

    def destroy
      @purchase = @customer.purchases.find(params[:id])
      @purchase.destroy
      head :no_content
    end

    private
    def purchase_params
      params.permit(:purchase_date, :customer_id, :product_id, :organization_id)
    end

    def set_organization
      @organization = Organization.find(params[:organization_id])
    end

    def set_customer
      @customer = @organization.customers.find_by!(params[:customer_id]) if @organization
    end
  end
end
