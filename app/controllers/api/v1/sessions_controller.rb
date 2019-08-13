# frozen_string_literal: true

# External API Endpoint to Check Against Order Completed Webhook

class Api::V1::SessionsController < ApiController

  def create
    user = User.find_by(fs_id: params[:user])
    if user
      session[:user_id] = user.fs_id
    else
      reset_session
    end
  end
end