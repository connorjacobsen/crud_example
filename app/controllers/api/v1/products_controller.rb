class Api::V1::ProductsController < ApplicationController
  private

    def resource_params
      params.permit(:name, :description, :price)
    end
end
