class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders
    if current_user.buffet_owner?
      @pending_orders = Order.where(event_type: current_user.buffet.event_types).pending
      @confirmed_orders = Order.where(event_type: current_user.buffet.event_types).confirmed
      @canceled_orders = Order.where(event_type: current_user.buffet.event_types).canceled
      @waiting_orders = Order.where(event_type: current_user.buffet.event_types).waiting
    end
  end

  def show
    @order = Order.find(params[:id])
    if current_user.buffet_owner?
      @same_date_orders = Order.joins(:event_type).where('event_types.buffet_id = ? AND date = ?', @order.event_type.buffet_id, @order.date)
    end
  end

  def new
    @event_type = EventType.find(params[:event_type_id])
    if current_user.client?
      @order = Order.new
    else
      redirect_to root_path, alert: 'Você precisa estar logado como cliente para fazer um pedido'
    end
  end

  def create
    order_params = params.require(:order).permit(
      :code, :date, :location, :details, :guests
    )
    @event_type = EventType.find(params[:event_type_id])
    @order = Order.new(order_params)
    @order.event_type = @event_type
    @order.user = current_user
    
    if @order.save 
      redirect_to order_path(@order),
      notice: 'Pedido realizado com sucesso'
    else
      flash.now[:notice] = "Pedido não pôde ser realizado"
      render 'new'
    end
  end
end