class BasePrice < ApplicationRecord
  belongs_to :event_type

  validates :title, :minimum_value, :additional_value_per_person, :extra_hour_value, presence: true
  validates :minimum_value, :additional_value_per_person, :extra_hour_value, numericality: { greater_than: 0 }
end
