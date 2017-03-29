module Api::V1
  class ProductsController < ApplicationController
    before_action :set_product, only: [:show, :update, :destroy]

    def index
      render json: Product.all
    end

    def show
      render json: @product
    end

    def create
      @product = Product.create!(product_params)
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

    def set_product
      @product = Product.find(params[:id])
    end
  end
end
