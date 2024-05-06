class Order < ApplicationRecord
  belongs_to :user
  belongs_to :event_type
  enum status: { pending: 0, confirmed: 1, canceled: 2, waiting: 3 }

  validates :date, :guests, :details, :code, presence: true
  validates :code, uniqueness: true
  validates :location, presence: true, if: :client_specified_address?
  
  before_validation :generated_code
  before_create :set_total_amount


  def self.weekend?(date)
    date.wday == 0 || date.wday == 6
  end

  def calculate_final_price(discount, extra_fee)
    self.total_amount - (self.total_amount/100) * discount + extra_fee
  end

  def calculate_base_price
    if self.event_type.base_prices.where(title: 'Finais de semana e feriados').any? && Order.weekend?(self.date)
      base_price = self.event_type.base_prices.find_by(title: 'Finais de semana e feriados')
      if self.guests > self.event_type.capacity_max
        base_price.minimum_value + base_price.additional_value_per_person * (self.guests - self.event_type.capacity_max)
      else
        base_price.minimum_value
      end  

    elsif self.event_type.base_prices.where(title: 'De segunda à sexta').any? && !Order.weekend?(self.date)
      base_price = self.event_type.base_prices.find_by(title: 'De segunda à sexta')
      if self.guests > self.event_type.capacity_max
        base_price.minimum_value + base_price.additional_value_per_person * (self.guests - self.event_type.capacity_max)
      else
        base_price.minimum_value
      end

    elsif self.event_type.base_prices.where(title: 'De segunda à domingo, incluindo feriados').any? 
      base_price = self.event_type.base_prices.find_by(title: 'De segunda à domingo, incluindo feriados')
      if self.guests > self.event_type.capacity_max
        base_price.minimum_value + base_price.additional_value_per_person * (self.guests - self.event_type.capacity_max)
      else
        base_price.minimum_value
      end
    end
  end

  private 

  def set_total_amount
    self.total_amount = calculate_base_price
  end

  def generated_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

  def client_specified_address?
    event_type.client_specified_address
  end
end