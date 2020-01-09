class AccountSettingsController < ApplicationController
  def Show
    # Get login info from session
    @UserInfo = Users.new(session[:UserInfo])

    # If login data is verified
    if @UserInfo.verify != true then
      redirect_to "/login"
    end
    @UserInfo = Users.find_by_ID(@UserInfo.ID)
  end

  def ChangePassword
    @UserInfo = Users.new(session[:UserInfo])

    if @UserInfo.verify == true and params[:password] != nil then
      @tmp = Users.find_by_ID(@UserInfo.ID)
      @tmp.PwHash = Users.password_to_hash(params[:password])
      @tmp.save
    end
    redirect_to "/sign-out"
  end

  def ChangeUserInfo
    @UserInfo = Users.new(session[:UserInfo])

    if @UserInfo.verify == true then
      @tmp = Users.find_by_ID(@UserInfo.ID)
      if @tmp.Name != params[:name] || @tmp.Address != params[:address] || @tmp.Email != params[:email] || @tmp.Phone != params[:phone] then
        byebug()
        @tmp.Name = params[:name]
        @tmp.Address = params[:address]
        @tmp.Email = params[:email]
        @tmp.Phone = params[:phone]
        @tmp.save
      end
      redirect_to "/account-settings"
    end
  end
end
