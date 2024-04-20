class BuffetsController < ApplicationController
  def show
    @buffet = Buffet.find(params[:id])
  end

  def new
    if user_signed_in? && current_user.buffet_owner? && !current_user.buffet
      @buffet = Buffet.new
      @users = User.all
    else
     redirect_to root_path, alert: 'Você não tem permissão para criar um buffet'
    end
  end

  def create
    buffet_params = params.require(:buffet).permit(
      :corporate_name, :brand_name, :registration_number, :telephone, 
      :email, :address, :district, :cep, :city, :state, :description, :payment_methods
    )
    @buffet = Buffet.new(buffet_params)
    @buffet.user = current_user

    if @buffet.save
      redirect_to buffet_path(@buffet),
      notice: 'Buffet cadastrado com sucesso!'
    else
      flash.now[:notice] = 'Buffet não cadastrado'
      render 'new'
    end
  end

  def edit
    @buffet = Buffet.find(params[:id])
    if @buffet == current_user.buffet
      render 'edit'
    else
      redirect_to root_path,
      notice: 'Você não tem permissão para editar o buffet de outro Dono de Buffet'
    end
  end

  def update
    @buffet = Buffet.find(params[:id])
    buffet_params = params.require(:buffet).permit(
      :corporate_name, :brand_name, :registration_number, :telephone, 
      :email, :address, :district, :cep, :city, :state, :description, :payment_methods
    )
    if @buffet.update(buffet_params)
      redirect_to buffet_path(@buffet.id),
      notice: 'Buffet atualizado com sucesso'
    else
      flash.now[:notice] = 'Não foi possível atualizar o Buffet'
      render 'edit'
    end
  end
end