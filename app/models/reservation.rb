class Reservation < ActiveRecord::Base
  belongs_to :item, class_name: 'Item', foreign_key: 'item_id'
  before_save :set_requested

  def set_requested
  	self.requested = "True"
  end
end
