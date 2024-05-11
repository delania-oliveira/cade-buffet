class Api::V1::BuffetsController < ActionController::API
  def show
    begin 
      buffet = Buffet.find(params[:id])
      render status: 200, json: buffet.as_json(except: [:created_at, :updated_at, :corporate_name, :registration_number])
    rescue
      return render status: 404
    end
  end

  def index
    buffets = Buffet.all
    render status: 200, json: buffets
  end

  def search 
    begin
      query = params[:query]
      buffets = Buffet.where('brand_name LIKE ?', "%#{query}%")
      render status: 200, json: buffets
    rescue 
      return render status: 404
    end
  end
  
end