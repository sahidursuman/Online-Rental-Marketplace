class Item < ActiveRecord::Base
  searchkick word_start: [:item_name]
  belongs_to :user
  attr_accessor :available_from, :available_to
  has_many :reservations
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

  def edit_sections_present?(item)
    if item.photos.present? && item.location.present? && item.calendar.present?
      return true
    end
  end

  def finish_listing
    update_attributes({
      listing_status: "Listed",
      lending_status: "Available"
    })
  end

  def set_lending_status_reserved
    self.update_attributes( lending_status: "Reserved")
  end

  def set_lending_status_available
    self.update_attributes( lending_status: "Available")
  end

  def set_listing_status_listed
    self.update_attributes( listing_status: "Listed")

  end

  def set_listing_status_unlisted
    self.update_attributes( listing_status: "Unlisted")
  end


  def default_values
  	self.lending_status = "Available" if self.lending_status.nil?
  end
end
