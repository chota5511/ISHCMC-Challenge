class CampusStaffs < ApplicationRecord
  self.table_name = "CampusStaffs"

  self.primary_key = :CampusID
  self.primary_key = :UserID

  def self.get_user_by_campusID(campusID)
    if campusID != nil then
      @users = Array.new
      @tmp = CampusStaffs.where(CampusID: campusID)
        @tmp.each do |r|
          @users << Users.find_by_ID(r.UserID)
        end
      return @users
    end
    return nil
  end

  def self.get_record_by_CampusID_UserID(campusID,userID)
    @tmp = CampusStaffs.where(CampusID: campusID)
    if @tmp != nil then
      @tmp.each do |s|
        if s.UserID.to_s == userID then
          return s
        end
      end
    end
    return nil
  end

  def self.get_record_by_CampusID(campusID)
    @tmp = CampusStaffs.where(CampusID: campusID)
    if @tmp != nil then
      return @tmp
    end
    return nil
  end

end
