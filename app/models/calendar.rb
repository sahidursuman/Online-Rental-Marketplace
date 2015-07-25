class Calendar < ActiveRecord::Base
  belongs_to :item
  before_save :set_reservation_type
  before_save :set_availab


  def set_reservation_type
  	self.reservation_type = "Request"
  end

  def set_availab
  	self.availability = "Calendar"
  end
end
