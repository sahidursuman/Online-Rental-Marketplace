class Item < ActiveRecord::Base
  belongs_to :user
  has_many :reservations, dependent: :destroy
  has_many :pictures, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :user_id, :item_name, :category, :description, :lending_price, presence: true
  validates :lending_price, presence: true, numericality: { greater_than: 0 }
  #validates :category, presence: true, inclusion: {}
  before_save :default_values

  def listings #feed equivalent ?
  	Item.where("user_id = ?", id)
  end

  def default_values
  	self.lending_status = "Available" if self.lending_status.nil?
  end
end
