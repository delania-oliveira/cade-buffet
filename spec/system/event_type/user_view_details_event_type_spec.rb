require 'rails_helper'

describe 'Usuário vê detalhes de um evento' do
  it 'do buffet do qual é dono' do
    user = User.create!(role: 'buffet_owner', email: 'joane@email.com', password: 'janne1')
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
    event_type = buffet.event_types.create!(
      name: 'Conferência de Tecnologia',
      description: 'Uma conferência para discutir as últimas tendências em tecnologia.',
      capacity_min: 100,
      capacity_max: 500,
      duration: 240,
      food_menu: 'Coffee break',
      alcoholic_drinks: false,
      decoration: true,
      parking_service: true,
      buffet_exclusive_address: false,
      client_specified_address: true
    )
    login_as(user)

    visit event_type_path(buffet)

    expect(page).to have_content 'Detalhes do Evento'
    expect(page).to have_content 'Nome do evento: Conferência de Tecnologia'
    expect(page).to have_content 'Descrição: Uma conferência para discutir as últimas tendências em tecnologia.'
    expect(page).to have_content 'Capacidade mínima de pessoas: 100'
    expect(page).to have_content 'Capacidade máxima de pessoas: 500'
    expect(page).to have_content 'Duração em minutos: 240'
    expect(page).to have_content 'Tipo de cardápio: Coffee break'
    expect(page).to have_content 'Serviços Oferecidos:'
    expect(page).to have_content 'Decoração'
    expect(page).to have_content 'Serviço de Estacionamento/Valet'
    expect(page).to have_content 'Flexibilidade de local:' 
    expect(page).to have_content 'Aceita endereço indicado pelo contratante'
    
    expect(page).to have_link 'Editar Informações'
    expect(page).to have_link 'Voltar'


  end
  it 'do buffet do qual não é dono' do
    user = User.create!(role: 'buffet_owner', email: 'joane@email.com', password: 'janne1')
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
    event_type = buffet.event_types.create!(
      name: 'Conferência de Tecnologia',
      description: 'Uma conferência para discutir as últimas tendências em tecnologia.',
      capacity_min: 100,
      capacity_max: 500,
      duration: 240,
      food_menu: 'Coffee break',
      alcoholic_drinks: false,
      decoration: true,
      parking_service: true,
      buffet_exclusive_address: false,
      client_specified_address: true
    )
    second_user = User.create!(role: 'buffet_owner', email: 'joae@email.com', password: 'janne1')
    second_buffet = second_user.create_buffet!(
      corporate_name: 'Buffet Estrela Dourada Ltda',
      brand_name: 'Buffet Estrela Dourada Eventos',
      registration_number: '12378000190',
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
    login_as(second_user)

    visit event_type_path(buffet)

    expect(page).to have_content 'Detalhes do Evento'
    expect(page).to have_content 'Nome do evento: Conferência de Tecnologia'
    expect(page).to have_content 'Descrição: Uma conferência para discutir as últimas tendências em tecnologia.'
    expect(page).to have_content 'Capacidade mínima de pessoas: 100'
    expect(page).to have_content 'Capacidade máxima de pessoas: 500'
    expect(page).to have_content 'Duração em minutos: 240'
    expect(page).to have_content 'Tipo de cardápio: Coffee break'
    expect(page).to have_content 'Serviços Oferecidos:'
    expect(page).to have_content 'Decoração'
    expect(page).to have_content 'Serviço de Estacionamento/Valet'
    expect(page).to have_content 'Flexibilidade de local:' 
    expect(page).to have_content 'Aceita endereço indicado pelo contratante'
    
    expect(page).not_to have_link 'Editar Informações'
    expect(page).to have_link 'Voltar'
  end 
end
