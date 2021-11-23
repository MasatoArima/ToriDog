class Info < ApplicationRecord
  has_one :customer

  validates :price_large, numericality: true, unless: -> { price_large.blank? }
  validates :price_medium, numericality: true, unless: -> { price_medium.blank? }
  validates :price_small, numericality: true, unless: -> { price_small.blank? }
end
