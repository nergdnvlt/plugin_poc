# frozen_string_literal: true

# External API Endpoint to create a new user off the FS Remote License Call

class Api::V1::UsersController < ApiController

  def create
    user = FastspringAccountService.build(params)
    if user
      render json: {"message": "user created" }, status: 200
    else
      render json: {"message": "user not created" }, status: 500
    end
  end
end