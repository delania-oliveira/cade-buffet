class Api::V1::EventTypesController < ActionController::API
  def index
    buffet = Buffet.find(params[:buffet_id])
    event_types = buffet.event_types
    
    if event_types.empty?
      render status: 404, json: { error: 'Esse buffet não possui eventos cadastrados' }
    else
      render status: 200, json: event_types
    end
  end
end