class DashBoardController < ApplicationController

  # Action to show the Admin's Dash board "dashboard/DashBoard":DashBoard.html.erb
  def DashBoard
    # Get login info from session
    @UserInfo = Users.new(session[:UserInfo])

    if @UserInfo.ID != true then
      # If login data is verified
      if @UserInfo.verify != true then
        redirect_to "/login"
      end

      @UserInfo = Users.find_by_ID(@UserInfo.ID)
    else
      redirect_to "/login"
    end
  end
end
