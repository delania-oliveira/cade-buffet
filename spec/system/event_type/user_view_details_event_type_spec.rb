require 'rails_helper'

describe 'Vê detalhes de um evento' do
  it 'do buffet do qual o usuário é dono do buffet' do
    user = User.create!(role: 'buffet_owner', email: 'joane@email.com', password: 'password')
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
  it 'do buffet do qual o usuário é dono de buffet, mas não é dono do buffet que está vendo' do
    user = User.create!(role: 'buffet_owner', email: 'joane@email.com', password: 'password')
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
    second_user = User.create!(role: 'buffet_owner', email: 'joae@email.com', password: 'password')
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
  it 'como visitante' do
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
    party_event_type = buffet.event_types.create!(
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
    party_base_price = party_event_type.base_prices.create!(
      title: 'De segunda a sexta-feira',
      minimum_value: 15000,
      additional_value_per_person: 200,
      extra_hour_value: 1500,
    )

    party_base_second_price = party_event_type.base_prices.create!(
      title: 'Finais de Semana',
      minimum_value: 35000,
      additional_value_per_person: 300,
      extra_hour_value: 2500,
    )
    
    visit event_type_path(buffet)

    expect(page).to have_content 'Detalhes do Evento'
    expect(page).to have_content 'Nome do evento: Festa de Aniversário'
    expect(page).to have_content 'Descrição: Uma festa para celebrar um aniversário especial com amigos e familiares.'
    expect(page).to have_content 'Capacidade mínima de pessoas: 30'
    expect(page).to have_content 'Capacidade máxima de pessoas: 100'
    expect(page).to have_content 'Duração em minutos: 300'
    expect(page).to have_content 'Tipo de cardápio: Buffet completo e bar aberto'
    expect(page).to have_content 'Serviços Oferecidos:'
    expect(page).to have_content 'Bebidas alcoólicas'
    expect(page).to have_content 'Decoração'
    expect(page).to have_content 'Serviço de Estacionamento/Valet'
    expect(page).to have_content 'Flexibilidade de local:' 
    expect(page).to have_content 'Aceita endereço indicado pelo contratante'
    expect(page).to have_content 'Valores do preço-base'
    expect(page).to have_content 'De segunda a sexta-feira'
    expect(page).to have_content 'Valor mínimo: R$ 15.000,00'
    expect(page).to have_content 'Valor adicional por pessoa: R$ 200,00'
    expect(page).to have_content 'Valor por hora extra: R$ 1.500,00'
    expect(page).to have_content 'Finais de Semana'
    expect(page).to have_content 'Valor mínimo: R$ 35.000,00'
    expect(page).to have_content 'Valor adicional por pessoa: R$ 300,00'
    expect(page).to have_content 'Valor por hora extra: R$ 2.500,00'

    expect(page).not_to have_link 'Editar valores'
    expect(page).not_to have_link 'Editar Informações'
    expect(page).to have_link 'Voltar'
  end
end
