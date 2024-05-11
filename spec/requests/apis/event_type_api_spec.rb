require 'rails_helper'

describe 'Event_type API' do
  context 'GET /api/v1/buffets/1/event_types' do
    it 'sucesso' do 
      user = User.create!(role: 'buffet_owner', email: 'janne@email.com', password: 'password')
      buffet = user.create_buffet!(
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
        payment_methods: 'Cartões de crédito, débito, transferência bancária e dinheiro'
      )
      buffet.event_types.create!(
        name: 'Conferência de Negócios',
        description: 'Uma conferência para discutir estratégias e tendências de negócios.',
        capacity_min: 50,
        capacity_max: 300,
        duration: 180,
        food_menu: 'Coffee break e almoço executivo',
        alcoholic_drinks: false,
        decoration: true,
        parking_service: true,
        buffet_exclusive_address: false,
        client_specified_address: true
      )
      buffet.event_types.create!(
        name: 'Workshop de Arte',
        description: 'Um workshop para explorar técnicas de pintura e expressão artística.',
        capacity_min: 20,
        capacity_max: 50,
        duration: 120,
        food_menu: 'Lanches leves e bebidas',
        alcoholic_drinks: false,
        decoration: true,
        parking_service: false,
        buffet_exclusive_address: true,
        client_specified_address: false
      )
      buffet.event_types.create!(
        name: 'Festa de Aniversário',
        description: 'Uma festa para celebrar um aniversário especial com amigos e familiares.',
        capacity_min: 30,
        capacity_max: 100,
        duration: 300,
        food_menu: 'Buffet completo e bar aberto',
        alcoholic_drinks: true,
        decoration: true,
        parking_service: true,
        buffet_exclusive_address: false,
        client_specified_address: true
      )
      
      get "/api/v1/buffets/#{buffet.id}/event_types"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 3
      expect(json_response[0]["name"]).to eq 'Conferência de Negócios'
      expect(json_response[1]["name"]).to eq 'Workshop de Arte'
      expect(json_response[2]["name"]).to eq 'Festa de Aniversário'
    end
    it 'retorne vazio se não existir eventos' do
      user = User.create!(role: 'buffet_owner', email: 'janne@email.com', password: 'password')
      buffet = user.create_buffet!(
        corporate_name: 'Buffet Estrela Ltda',
        brand_name: 'Buffet Estrela Eventos',
        registration_number: '1234000190',
        telephone:'11987654321',
        email:'contato@estreladouradaeventos.com.br',
        address: 'Rua das Flores, 123',
        district:'Centro',
        cep:'12345678',
        city:'Cidade Luz',
        state:'São Paulo',
        description:'O Buffet Eventos Estrela Dourada é um lugar mágico onde seus sonhos se tornam realidade. Com ambientes elegantes e serviços de alta qualidade, estamos prontos para tornar seu evento inesquecível',
        payment_methods: 'Cartões de crédito, débito, transferência bancária, Pix e dinheiro'
      )

      get "/api/v1/buffets/#{buffet.id}/event_types"

      expect(response.status).to eq 404
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response["error"]).to eq 'Esse buffet não possui eventos cadastrados'
    end
  end
end