module Api::V1
  class ProductsController < ApplicationController
    before_action :set_organization
    before_action :set_product, only: [:show, :update, :destroy]

    def index
      render json: @organization.products
    end

    def show
      render json: @product
    end

    def create
      @product = @organization.products.create!(product_params)
      render json: @product, status: :created
    end

    def update
      @product.update(product_params)
      head :no_content
    end

    def destroy
      @product.destroy
      head :no_content
    end

    private
    def product_params
      params.permit(:brand, :model, :cost, :btu)
    end

    def set_organization
      @organization = Organization.find(params[:organization_id])
    end

    def set_product
      @product = @organization.products.find_by!(id: params[:id])
    end
  end
end
