class Transaction < ActiveRecord::Base
  belongs_to :reservation
end
