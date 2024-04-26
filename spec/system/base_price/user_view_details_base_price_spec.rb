require 'rails_helper'

describe 'Usuário vê detalhes do preço-base de um evento' do
  it 'do evento do buffet do qual é dono' do
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
    base_price = event_type.base_prices.create!(
      title: 'De segunda a sexta-feira',
      minimum_value: 10000,
      additional_value_per_person: 150,
      extra_hour_value: 1000,
    )
    login_as(user)

    visit base_price_path(base_price)

    expect(page).to have_content 'Preço-base'
    expect(page).to have_content 'Título: De segunda a sexta-feira'
    expect(page).to have_content 'Valor mínimo: R$ 10.000,00'
    expect(page).to have_content 'Valor adicional por pessoa: R$ 150,00'
    expect(page).to have_content 'Valor por hora extra: R$ 1.000,00'
    expect(page).to have_link 'Editar Valores'
    expect(page).to have_link 'Voltar'
  end
  it 'do evento do buffet do qual não é dono' do
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
    base_price = event_type.base_prices.create!(
      title: 'De segunda a sexta-feira',
      minimum_value: 10000,
      additional_value_per_person: 150,
      extra_hour_value: 1000,
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

    visit base_price_path(base_price)

    expect(page).to have_content 'Preço-base'
    expect(page).to have_content 'Título: De segunda a sexta-feira'
    expect(page).to have_content 'Valor mínimo: R$ 10.000,00'
    expect(page).to have_content 'Valor adicional por pessoa: R$ 150,00'
    expect(page).to have_content 'Valor por hora extra: R$ 1.000,00'
    expect(page).not_to have_link 'Editar Informações'
    expect(page).to have_link 'Voltar'
  end 
end