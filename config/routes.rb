Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # Set scope admin's root
  root 'dash_board#DashBoard'

  # Get method for admin scope declare here
  get 'dash-board' => 'dash_board#DashBoard'

  ## Login
  get 'login' => 'login#Show'
  get 'sign-out' => 'login#SignOut'

  ## Users
  get 'users' => 'users#Show'
  get 'users/:id/delete' => 'users#Delete'
  get 'users/:id/enable' => 'users#Enable'

  ## Account Settings
  get 'account-settings' => 'account_settings#Show'

  ## Campus
  get 'campus/:id' => 'campus#Detail'
  get 'campus/:id/add-staff' => 'campus#ChooseStaff'
  get 'campus/:id/:userid/delete-staff' => 'campus#DeleteStaff'
  get 'campus/:id/:userid/add-staff' => 'campus#AddStaff'
  get 'campus/:id/delete' => 'campus#DeleteCampus'

  # Post method for admin scope declare here

  ## Login
  post 'login/submit' => 'login#Login'

  ## Users
  post 'users/:id/edit' => 'users#Edit'
  post 'users/create' => 'users#Create'
  post 'users/search' => 'users#Search'

  ## Account Settings
  post 'account-settings/change-password' => 'account_settings#ChangePassword'
  post 'account-settings/change-info' => 'account_settings#ChangeUserInfo'

  ## Campus
  post 'campus/add-campus' => 'campus#AddCampus'
  post 'campus/:id/edit' => 'campus#EditCampus'

end
