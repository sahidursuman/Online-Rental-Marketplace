class Location < ActiveRecord::Base
	searchkick word_start: [:city, :state]
  belongs_to :item
end
