class ProductsController < ApplicationController
  before_action :set_product, only: [:show]

  def index
    @products = Product.all
  end

  def show
    @product
  end

  private

  def set_product
    @product = Product.find_by(path: params[:path])
  end
end
