class BasePricesController < ApplicationController
  def show
    @base_price = BasePrice.find(params[:id])
  end

  def new
    @event_type = EventType.find(params[:event_type_id])
    if user_signed_in? && current_user.buffet_owner? && current_user.buffet && @event_type.base_prices.count < 2
      @base_price = BasePrice.new
    else
    redirect_to root_path, alert: 'Você não tem permissão para acessar essa página.'
    end
  end

  def create
    base_price_params = params.require(:base_price).permit(
      :title, :minimum_value, :additional_value_per_person, :extra_hour_value
    )
    @event_type = EventType.find(params[:event_type_id])
    @base_price = BasePrice.new(base_price_params)
    @base_price.event_type = @event_type

    if @base_price.save
      redirect_to base_price_path(@base_price),
      notice: 'Preço-base cadastrado com sucesso!'
    else
      flash.now[:notice] = 'Preço-base não cadastrado'
      render 'new'
    end
  end

  def edit
    @base_price = BasePrice.find(params[:id])
    if @base_price.event_type.buffet == current_user.buffet
      render 'edit'
    else
      redirect_to root_path,
      notice: 'Você não tem permissão para acessar essa página.'
    end
  end

  def update
    @base_price = BasePrice.find(params[:id])
    base_price_params = params.require(:base_price).permit(
      :title, :minimum_value, :additional_value_per_person, :extra_hour_value
    )
    if @base_price.update(base_price_params)
      redirect_to base_price_path(@base_price.id),
      notice: 'Preço-base atualizado com sucesso'
    else
      flash.now[:notice] = 'Não foi possível atualizar o preço-base'
      render 'edit'
    end
  end
end