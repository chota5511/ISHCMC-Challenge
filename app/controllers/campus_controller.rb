class CampusController < ApplicationController
  def Detail
    @UserInfo = Users.new(session[:UserInfo])
    # If login data is verified
    if @UserInfo.verify == true && Administrators.find_by_UserID(@UserInfo.ID) != nil then
      @UserInfo = Users.new(session[:UserInfo])
      @Campus = Campuses.find_by_ID(params[:id])
      @Users = CampusStaffs.get_user_by_campusID(@Campus.ID)
    else
      redirect_to '/dash-board'
    end
  end

  def EditCampus
    # Get login info from session
    @UserInfo = Users.new(session[:UserInfo])
    # If login data is verified
    if @UserInfo.verify == true && Administrators.find_by_UserID(@UserInfo.ID) != nil then
      @tmp = Campuses.find_by_ID(params[:id])
      @tmp.Name = params[:name]
      @tmp.Address = params[:address]
      @tmp.save
      redirect_to '/campus/' + params[:id]
    else
      redirect_to '/dash-board'
    end
  end

  def DeleteCampus
    @UserInfo = Users.new(session[:UserInfo])
    # If login data is verified
    if @UserInfo.verify == true && Administrators.find_by_UserID(@UserInfo.ID) != nil then
      @tmp = Campuses.find_by_ID(params[:id])
      if @tmp != nil then
        @staffs = CampusStaffs.get_record_by_CampusID(params[:id])
        @staffs.each do |s|
          s.destroy
        end
        @tmp.destroy
      end
    end
    redirect_to '/dash-board'
  end

  def AddCampus
    # Get login info from session
    @UserInfo = Users.new(session[:UserInfo])
    # If login data is verified
    if @UserInfo.verify == true && Administrators.find_by_UserID(@UserInfo.ID) != nil then
      @tmp = Campuses.new
      @tmp.ID = params[:campusid]
      @tmp.Name = params[:name]
      @tmp.Address = params[:address]
      @tmp.save
      redirect_back(fallback_location: root_path)
    else
      redirect_to '/dash-board'
    end
  end

  def AddStaff
    # Get login info from session
    @UserInfo = Users.new(session[:UserInfo])
    # If login data is verified
    if @UserInfo.verify == true && Administrators.find_by_UserID(@UserInfo.ID) != nil then
      @tmp = CampusStaffs.new
        if CampusStaffs.get_record_by_CampusID_UserID(params[:id],params[:userid]) == nil
          @tmp.CampusID = params[:id]
          @tmp.UserID = params[:userid]
          @tmp.save
        end
    else
      redirect_to '/dash-board'
    end
    redirect_to '/campus/' + params[:id]
  end

  def ChooseStaff
    # Get login info from session
    @UserInfo = Users.new(session[:UserInfo])
    # If login data is verified
    if @UserInfo.verify == true && Administrators.find_by_UserID(@UserInfo.ID) != nil then
      @Users = Users.all
      @Campus = Campuses.find_by_ID(params[:id])
    else
      redirect_to '/dash-board'
    end

    @UserInfo = Users.find_by_ID(@UserInfo.ID)
  end

  def DeleteStaff
    @UserInfo = Users.new(session[:UserInfo])
    # If login data is verified
    if @UserInfo.verify == true && Administrators.find_by_UserID(@UserInfo.ID) != nil then
      @tmp = CampusStaffs.get_record_by_CampusID_UserID(params[:id],params[:userid])
      if @tmp != nil then
        @tmp.delete
      end
      redirect_to '/campus/' + params[:id]
    else
      redirect_to '/dash-board'
    end
  end
end
