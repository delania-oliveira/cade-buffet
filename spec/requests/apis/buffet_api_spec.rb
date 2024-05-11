require 'rails_helper'

describe 'Buffet API' do
  context 'GET /api/v1/buffets/1' do
    it 'successo' do
      user = User.create!(role: 'buffet_owner', email: 'jnne@email.com', password: 'password')
      buffet = user.create_buffet!(
        corporate_name: 'Buffet Estrela Dourada Ltda',
        brand_name: 'Buffet Estrela Dourada Eventos',
        registration_number: '12345678000190',
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

      get "/api/v1/buffets/#{buffet.id}"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response["brand_name"]).to eq 'Buffet Estrela Dourada Eventos'
      expect(json_response.keys).not_to include "created_at"
      expect(json_response.keys).not_to include "updated_at"
      expect(json_response.keys).not_to include "corporate_name"
      expect(json_response.keys).not_to include "registration_number"
    end
    it 'falha se o buffet não for encontrado' do 
      get "/api/v1/buffets/99999999"

      expect(response.status).to eq 404
    end
  end
  context 'GET /api/v1/buffets' do
    it 'sucesso' do 
      first_buffet = User.create!(role: 'buffet_owner', email: 'joane@email.com', password: 'password')
      first_buffet.create_buffet!(
        corporate_name: 'Buffet Estrela Dourada Ltda',
        brand_name: 'Buffet Estrela Dourada Eventos',
        registration_number: '12345678000190',
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
      second_user = User.create!(role: 'buffet_owner', email: 'janne@email.com', password: 'password')
      second_buffet = second_user.create_buffet!(
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
      
      get '/api/v1/buffets'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response[0]["brand_name"]).to eq 'Buffet Estrela Dourada Eventos'
      expect(json_response[1]["brand_name"]).to eq 'Buffet Estrela Eventos'
    end
    it 'retorne vazio se não existir buffets' do
      get '/api/v1/buffets'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end
  end
  context 'GET /api/v1/buffets/search?query=name' do
    it 'sucesso' do
      first_buffet = User.create!(role: 'buffet_owner', email: 'joane@email.com', password: 'password')
      first_buffet.create_buffet!(
        corporate_name: 'Buffet Estrela Dourada Ltda',
        brand_name: 'Buffet Estrela Dourada Eventos',
        registration_number: '12345678000190',
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
      second_user = User.create!(role: 'buffet_owner', email: 'janne@email.com', password: 'password')
      second_buffet = second_user.create_buffet!(
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

      get "/api/v1/buffets/search?query=#{second_buffet.brand_name}"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 1
      expect(json_response[0]["brand_name"]).to eq 'Buffet Estrela Eventos'
    end
    it 'retorne vazio se não encontrar nenhum buffet' do
      
      get '/api/v1/buffets/search?query=estrela'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end

  end
end