require 'rails_helper'

describe 'Order API' do
  context '' do

    it 'disponibilidade' do
      client = User.create!(role: 'client', name: 'Janne', individual_registration: '23361142083', email: 'jsne@email.com', password: 'password')
      buffet_owner = User.create!(role: 'buffet_owner', email: 'janne@email.com', password: 'password')
      buffet = buffet_owner.create_buffet!(
        corporate_name: 'Buffet Harmonia dos Sabores Ltda',
        brand_name: 'Buffet Harmonia dos Sabores Eventos',
        registration_number: '13579246000190',
        telephone: '1133334444',
        email: 'contato@harmoniadosabores.com.br',
        address: 'Rua das Delícias, 789',
        district: 'Vila Gastronômica',
        cep: '98765432',
        city: 'Cidade dos Sabores',
        state: 'Minas Gerais',
        description: 'O Buffet Eventos Harmonia dos Sabores proporciona uma combinação única de sabores e experiências para seu evento. Com menus personalizados e um ambiente acolhedor, estamos prontos para fazer do seu evento um verdadeiro sucesso.',
        payment_methods: 'Pix, transferência bancária e dinheiro'
      )
      event = buffet.event_types.create!(
        name: 'Evento de confraternização',
        description: 'Um evento especial para relaxar, se divertir e estreitar laços com colegas',
        capacity_min: 100,
        capacity_max: 500,
        duration: 240,
        food_menu: 'Jantar com frutos do mar e vinhos',
        alcoholic_drinks: true,
        decoration: true,
        parking_service: false,
        buffet_exclusive_address: false,
        client_specified_address: true
      )
      event.base_prices.create!(
        title: 'De segunda à sexta',
        minimum_value: 10000,
        additional_value_per_person: 150,
        extra_hour_value: 1000,
      )
      event.base_prices.create!(
        title: 'Finais de semana e feriados',
        minimum_value: 35000,
        additional_value_per_person: 250,
        extra_hour_value: 3000,
      )
      Order.create!(
        user: client,
        event_type: event, 
        date: '2024-07-14', 
        guests: 150, 
        details: 'Evento de confraternização de fim de ano da empresa ABC Corp., incluindo jantar e entretenimento ao vivo.',
        location: 'Rua das Palmeiras, 500, Bairro Jardim Tropical, Cidade Sol, São Paulo',
        status: 'confirmed'
      )
      Order.create!(
        user: client,
        event_type: event, 
        date: '2024-11-15', 
        guests: 150, 
        details: 'Evento de confraternização de fim de ano da empresa ABC Corp., incluindo jantar e entretenimento ao vivo.',
        location: 'Rua das Palmeiras, 500, Bairro Jardim Tropical, Cidade Sol, São Paulo',
        status: 'canceled'
      )
      
      post "/api/v1/buffets/#{buffet.id}/event_types/#{event.id}/orders/check_availability?date=2024-07-15&guests=100"
      
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response["initial_price"]).to eq 10000
    end
    it 'indisponibilidade' do
      client = User.create!(role: 'client', name: 'Janne', individual_registration: '23361142083', email: 'jsne@email.com', password: 'password')
      buffet_owner = User.create!(role: 'buffet_owner', email: 'janne@email.com', password: 'password')
      buffet = buffet_owner.create_buffet!(
        corporate_name: 'Buffet Harmonia dos Sabores Ltda',
        brand_name: 'Buffet Harmonia dos Sabores Eventos',
        registration_number: '13579246000190',
        telephone: '1133334444',
        email: 'contato@harmoniadosabores.com.br',
        address: 'Rua das Delícias, 789',
        district: 'Vila Gastronômica',
        cep: '98765432',
        city: 'Cidade dos Sabores',
        state: 'Minas Gerais',
        description: 'O Buffet Eventos Harmonia dos Sabores proporciona uma combinação única de sabores e experiências para seu evento. Com menus personalizados e um ambiente acolhedor, estamos prontos para fazer do seu evento um verdadeiro sucesso.',
        payment_methods: 'Pix, transferência bancária e dinheiro'
      )
      event = buffet.event_types.create!(
        name: 'Evento de confraternização',
        description: 'Um evento especial para relaxar, se divertir e estreitar laços com colegas',
        capacity_min: 100,
        capacity_max: 500,
        duration: 240,
        food_menu: 'Jantar com frutos do mar e vinhos',
        alcoholic_drinks: true,
        decoration: true,
        parking_service: false,
        buffet_exclusive_address: false,
        client_specified_address: true
      )
      event.base_prices.create!(
        title: 'De segunda à sexta',
        minimum_value: 10000,
        additional_value_per_person: 150,
        extra_hour_value: 1000,
      )
      event.base_prices.create!(
        title: 'Finais de semana e feriados',
        minimum_value: 35000,
        additional_value_per_person: 250,
        extra_hour_value: 3000,
      )
      Order.create!(
        user: client,
        event_type: event, 
        date: '2024-07-14', 
        guests: 150, 
        details: 'Evento de confraternização de fim de ano da empresa ABC Corp., incluindo jantar e entretenimento ao vivo.',
        location: 'Rua das Palmeiras, 500, Bairro Jardim Tropical, Cidade Sol, São Paulo',
        status: 'confirmed'
      )
      
      post "/api/v1/buffets/#{buffet.id}/event_types/#{event.id}/orders/check_availability?date=2024-07-14&guests=150"
    
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response["message"]).to eq 'O buffet não está disponível para essa data'

    end
  end
end