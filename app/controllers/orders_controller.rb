class OrdersController < ApplicationController
  def index
    @orders = current_user.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @event_type = EventType.find(params[:event_type_id])
    if user_signed_in? && current_user.client?
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