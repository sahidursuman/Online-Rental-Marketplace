class Reservation < ActiveRecord::Base
  belongs_to :item, class_name: 'Item', foreign_key: 'item_id'
  before_create :set_requested
  before_create :set_request_status

  def set_requested
  	self.requested = "True"
  end

  def set_request_status
  	update_attributes(request_status: "Pending")
  end

  def set_request_approved
  	update_attributes( request_status: "Approved")
  end

end
