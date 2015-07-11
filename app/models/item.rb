class Item < ActiveRecord::Base
  belongs_to :user
  attr_accessor :available_from, :available_to
  has_many :reservations, dependent: :destroy
  has_many :photos, dependent: :destroy
  has_one :location, dependent: :destroy
  has_one :calendar, dependent: :destroy
  #default_scope -> { order(created_at: :desc) }
  validates :item_name, :category, :description, :lending_price, presence: true #removed :user_id
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
