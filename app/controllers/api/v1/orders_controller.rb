class Api::V1::OrdersController < ActionController::API
  def check_availability
    date = params[:date].to_date
    guests = params[:guests].to_i
    event_type_id = params[:event_type_id]
    event_type = EventType.find(event_type_id)

    confirmed_order = Order.where(
      date: date.to_s, status: 'confirmed', event_type_id: event_type_id
    ).first
    
    if guests > event_type.capacity_max || guests < event_type.capacity_min
      render status: 200, json: { guest_message: 'A quantidade de convidados é maior ou menor que a quantidade mínima ou máxima suportada'}
    elsif confirmed_order
      render status: 200, json: { unavailable_message: 'O buffet não está disponível para essa data'}
    else
      initial_price = calculate_initial_price(event_type, guests, date)
      render status: 200, json: {initial_price: initial_price}
    end
  end

  private
  def calculate_initial_price(event_type, guests, date)
    if event_type.base_prices.where(title: 'Finais de semana e feriados').any? && Order.weekend?(date)
      base_price = event_type.base_prices.find_by(title: 'Finais de semana e feriados')
      base_price.minimum_value.to_i 
    elsif event_type.base_prices.where(title: 'De segunda à sexta').any? && !Order.weekend?(date)
      base_price = event_type.base_prices.find_by(title: 'De segunda à sexta')
      base_price.minimum_value.to_i
    elsif event_type.base_prices.where(title: 'De segunda à domingo, incluindo feriados').any?
      base_price = event_type.base_prices.find_by(title: 'De segunda à domingo, incluindo feriados')
      base_price.minimum_value.to_i
    end
  end
end