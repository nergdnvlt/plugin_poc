# frozen_string_literal: true

class ApiController < ActionController::Base
  protect_from_forgery except: [:create]
end