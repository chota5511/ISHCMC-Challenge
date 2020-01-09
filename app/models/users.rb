require 'digest'

class Users < ApplicationRecord
  self.table_name = "Users"

  def self.password_to_hash(password)
    return Digest::MD5.hexdigest(password)
  end

  def verify
    if self.UserName != nil && self.PwHash != nil then
      # Get Admin user's info from database
      @tmp = Users.find_by_UserName(self.UserName)
      # Check if Admin user ID is available
      if @tmp != nil then
        # Check if User's password hash (MD5 with no salt) on database is match with typed password
        if @tmp.PwHash == self.PwHash && @tmp.Enabled == true then
          # Return true if match
          return true
        end
      end
    end
    return false
  end

end
