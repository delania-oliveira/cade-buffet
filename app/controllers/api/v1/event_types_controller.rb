class Api::V1::EventTypesController < ActionController::API
  def index
    event_types = EventType.all
    
    if event_types.empty?
      render status: 404, json: { error: 'Esse buffet não possui eventos cadastrados' }
    else
      render status: 200, json: event_types
    end
  end
end