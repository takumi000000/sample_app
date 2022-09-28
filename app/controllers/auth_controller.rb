class AuthController < ApplicationController
  def new
    @user = User.new
  end
  
end
