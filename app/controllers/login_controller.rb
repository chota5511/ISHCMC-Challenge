require 'digest'

class LoginController < ApplicationController
  #Set this controller has no layout
  layout false

  #Action to show Login view "login/Show":Show.html.erb
  def Show
    @UserInfo = Users.new(session[:UserInfo])
    if @UserInfo.verify == true then
      @UserInfo = Users.find_by_ID(@UserInfo.ID)
      redirect_to "/dash-board"
    end
  end

  #Action to get and verify the in put Admin user name and password "login/Login"
  def Login
    @tmp = Users.new
    @tmp.UserName = params[:username]
    @tmp.PwHash = Users.password_to_hash(params[:password]).to_s
    if @tmp.verify == true then
      session[:UserInfo] = Users.find_by_UserName(@tmp.UserName)
      if session[:LoginStatus] != nil then
         session[:LoginStatus] = nil
      end
      redirect_to "/dash-board"
    else
      session[:LoginStatus] = "User ID or password is incorect"
      redirect_to "/login"
    end
  end

  #Action to clear up Admin session and logout
  def SignOut
    if session[:UserInfo] != nil then
      session[:UserInfo] = nil
      redirect_to "/login"
    else
      redirect_to "/login"
    end
  end
end
