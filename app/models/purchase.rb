class Purchase < ApplicationRecord
  belongs_to :member
  belongs_to :credit_card
end