class Order < ApplicationRecord
  belongs_to :user
  belongs_to :event_type
  enum status: { pending: 0, confirmed: 1, canceled: 2, waiting: 3 }

  validates :date, :guests, :details, :code, presence: true
  validates :code, uniqueness: true
  validates :location, presence: true, if: :client_specified_address?
  
  before_validation :generated_code

  private 

  def generated_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

  def client_specified_address?
    event_type.client_specified_address
  end
end