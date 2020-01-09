class UsersController < ApplicationController

  #Action to show ShowView "project/Show":Show.html.erb
  def Show
    # Get login info from session
    @UserInfo = Users.new(session[:UserInfo])
    # If login data is verified
    if @UserInfo.verify == true && Administrators.find_by_UserID(@UserInfo.ID) != nil then
      @Users = Users.all
    else
      redirect_to '/dash-board'
    end

    @UserInfo = Users.find_by_ID(@UserInfo.ID)
  end

  # Action to edit the selected project
  def Edit
    # Get login info from session
    @UserInfo = Users.new(session[:UserInfo])

    # If login data is verified
    if @UserInfo.verify == true && Administrators.find_by_UserID(@UserInfo.ID) != nil then
      @tmp = Users.find_by_ID(params[:id])

      # If any of the parameters was changed
      if @tmp.Name != params[:name] || @tmp.UserName != params[:username] || params[:password] != "" || @tmp.Address != params[:address] || @tmp.Email != params[:email] || @tmp.Phone != params[:phone] then

        @tmp.Name = params[:name]
        @tmp.UserName = params[:username]
        if params[:password] != "" then
          @tmp.PwHash = Users.password_to_hash(params[:password]).to_s
        end
        @tmp.Address = params[:address]
        @tmp.Email = params[:email]
        @tmp.Phone = params[:phone]

        # Override project image by new project image
        #if image_io != nil then
          #File.open(Rails.root.join('app','assets','images',"p#{@tmp.id}.png"),'wb') do |file|
            #file.write(image_io.read)
          #end
        #end

        # Save changed
        @tmp.save
      end
      redirect_to '/users'
    else
      redirect_to '/dash-board'
    end
  end

  # Action to create a project
  def Create
    # Get login info from session
    @UserInfo = Users.new(session[:UserInfo])

    # If login data is verified
    if @UserInfo.verify == true && Administrators.find_by_UserID(@UserInfo.ID) != nil then
      # Create a project
      @tmp = Users.new
      @tmp.Name = params[:name]
      @tmp.UserName = params[:username]
      @tmp.PwHash = Users.password_to_hash(params[:password]).to_s
      @tmp.Address = params[:address]
      @tmp.Email = params[:email]
      @tmp.Phone = params[:phone]
      @tmp.save

      # Create project image with project ID
      #image_io = params[:image]
      #File.open(Rails.root.join('app','assets','images',"p#{@tmp.id}.png"),'wb') do |file|
        #file.write(image_io.read)
      #end
      redirect_to '/users'
    else
      redirect_to '/dash-board'
    end
  end

  # Action to search for project
  def Search
    # Get login info from session
    @UserInfo = Users.new(session[:UserInfo])

    # If login data is verified
    if @UserInfo.verify == true then

      # Initial new array to store project of the searcher
      @project = Array.new

      # Find project that the keywords match with project's keywords pool
      Users.all.each do |u|
        if u.search(params[:key]) == true then
          @users << u
        end
      end
      render 'Show'
    else
      redirect_to '/dash-board'
    end
  end

  # Action to delete (Only disable do not delete the record) a user
  def Delete
    # Get login info from session
    @UserInfo = Users.new(session[:UserInfo])

    # If login data is verified
    if @UserInfo.verify == true && Administrators.find_by_UserID(@UserInfo.ID) != nil then
      # Find project by ID
      @tmp = Users.find_by_ID(params[:id])

      # If project ID is available
      if @tmp != nil and @tmp.UserName != 'admin' then
        # Delete a project with project ID
        @tmp.Enabled = false
        @tmp.save

        redirect_to '/users'
      end
    else
      redirect_to '/dash-board'
    end
  end

  # Action to Enable a user
  def Enable
    # Get login info from session
    @UserInfo = Users.new(session[:UserInfo])

    # If login data is verified
    if @UserInfo.verify == true && Administrators.find_by_UserID(@UserInfo.ID) != nil then
      # Find project by ID
      @tmp = Users.find_by_ID(params[:id])

      # If project ID is available
      if @tmp != nil then
        # Delete a project with project ID
        @tmp.Enabled = true
        @tmp.save

        redirect_to '/users'
      end
    else
      redirect_to '/dash-board'
    end
  end

  def SetAdministrator
    @UserInfo = User.new(session[:UserInfo])
    if @UserInfo.verify == true && Administrators.find_by_UserID(@UserInfo.ID) != nil then
      # Find project by ID
      @tmp = Users.find_by_ID(params[:id])
      @admin = Administrators.find_by_UserID(params[:id])

      # If project ID is available
      if @tmp != nil && @admin == nil then
        # Delete a project with project ID
          @admin = Administrators.new
          @admin.UserID = @tmp.ID
          @admin.save
        redirect_to '/users'
      end
    else
      redirect_to '/dash-board'
    end
  end
end
