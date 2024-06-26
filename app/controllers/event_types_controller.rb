class EventTypesController < ApplicationController
  def show
    @event_type = EventType.find(params[:id])
  end
  
  def new
    if user_signed_in? && current_user.buffet_owner? && current_user.buffet
      @event_type = EventType.new
    else
     redirect_to root_path, alert: 'Você não tem permissão para acessar essa página.'
    end
  end

  def create
    event_type_params = params.require(:event_type).permit(
      :name, :description, :capacity_min, :capacity_max, :duration, :food_menu,
      :alcoholic_drinks, :decoration, :parking_service, :buffet_exclusive_address,
      :client_specified_address, images: []
    )
    @event_type = EventType.new(event_type_params)
    @event_type.buffet = current_user.buffet

    if @event_type.save
      redirect_to event_type_path(@event_type),
      notice: 'Evento cadastrado com sucesso!'
    else
      flash.now[:notice] = 'Evento não cadastrado'
      render 'new'
    end
  end

  def edit
    @event_type = EventType.find(params[:id])
    if @event_type.buffet == current_user.buffet
       render 'edit'
    else
      redirect_to root_path,
      notice: 'Você não tem permissão para acessar essa página.'
    end
  end

  def update
    @event_type = EventType.find(params[:id])
    event_type_params = params.require(:event_type).permit(
      :name, :description, :capacity_min, :capacity_max, :duration, :food_menu,
      :alcoholic_drinks, :decoration, :parking_service, :buffet_exclusive_address,
      :client_specified_address, images: []
    )
    if params[:event_type][:remove_image_ids].is_a?(Array)
      params[:event_type][:remove_image_ids].each do |id|
        image = @event_type.images.find(id)
        image.purge
      end
    end

    if @event_type.update(event_type_params)
      redirect_to event_type_path(@event_type.id),
      notice: 'Evento atualizado com sucesso'
    else
      flash.now[:notice] = 'Não foi possível atualizar o Evento'
      render 'edit'
    end
  end

end