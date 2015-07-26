class Reservation < ActiveRecord::Base
  belongs_to :item, class_name: 'Item', foreign_key: 'item_id'
  before_create :set_requested
  before_create :set_request_status

  def set_requested
  	self.requested = "True"
  end

  def set_request_status
  	self.request_status = "Pending"
  end
end
