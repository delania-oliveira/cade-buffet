require 'rails_helper'

describe 'Dono de Buffet cadastra uma configuração de preço base de um evento' do
  it 'com sucesso' do
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
    buffet.event_types.create!(
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

    visit buffet_path(buffet)
    click_on 'Ver Detalhes', :match => :first
    click_on 'Definir preço-base'
    fill_in 'Título', with: 'De segunda a sexta-feira'
    fill_in 'Valor mínimo', with: '10000'
    fill_in 'Valor adicional por pessoa', with: '150'
    fill_in 'Valor por hora extra', with: '1000'
    click_on 'Cadastrar preço-base'

    expect(current_path).to eq base_price_path(BasePrice.last)
    expect(page).to have_content 'Título: De segunda a sexta-feira'
    expect(page).to have_content 'Valor mínimo: R$ 10.000,00'
    expect(page).to have_content 'Valor adicional por pessoa: R$ 150,00'
    expect(page).to have_content 'Valor por hora extra: R$ 1.000,00'
    expect(page).to have_link 'Editar Valores'
    expect(page).to have_link 'Voltar'
  end
  it 'uma segunda configuração com sucesso' do
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
    event_type.base_prices.create!(
      title: 'De segunda a sexta-feira',
      minimum_value: 10000,
      additional_value_per_person: 150,
      extra_hour_value: 1000,
    )
    login_as(user)

    visit buffet_path(buffet)
    click_on 'Ver Detalhes', :match => :first
    click_on 'Definir preço-base'
    fill_in 'Título', with: 'Finais de semana'
    fill_in 'Valor mínimo', with: '30000'
    fill_in 'Valor adicional por pessoa', with: '300'
    fill_in 'Valor por hora extra', with: '3000'
    click_on 'Cadastrar preço-base'

    expect(current_path).to eq base_price_path(BasePrice.last)
    expect(page).to have_content 'Título: Finais de semana'
    expect(page).to have_content 'Valor mínimo: R$ 30.000,00'
    expect(page).to have_content 'Valor adicional por pessoa: R$ 300,00'
    expect(page).to have_content 'Valor por hora extra: R$ 3.000,00'
    expect(page).to have_link 'Editar Valores'
    expect(page).to have_link 'Voltar'
  end
  it 'uma terceira configuração' do
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
    event_type.base_prices.create!(
      title: 'De segunda a sexta-feira',
      minimum_value: 10000,
      additional_value_per_person: 150,
      extra_hour_value: 1000,
    )
    event_type.base_prices.create!(
      title: 'Finais de semana',
      minimum_value: 30000,
      additional_value_per_person: 300,
      extra_hour_value: 3000,
    )
    login_as(user)

    visit buffet_path(buffet)
    click_on 'Ver Detalhes', :match => :first

    expect(page).not_to have_link 'Definir preço-base'
  end
  it 'com dados incompletos' do
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

    visit buffet_path(buffet)
    click_on 'Ver Detalhes', :match => :first
    click_on 'Definir preço-base'
    click_on 'Cadastrar preço-base'

    expect(page).to have_content 'Preço-base não cadastrado'
    expect(page).to have_content 'Título não pode ficar em branco'
    expect(page).to have_content 'Valor mínimo não pode ficar em branco'
    expect(page).to have_content 'Valor adicional por pessoa não pode ficar em branco'
    expect(page).to have_content 'Valor por hora extra não pode ficar em branco'
    expect(page).to have_content 'Valor mínimo não é um número' 
    expect(page).to have_content 'Valor adicional por pessoa não é um número' 
    expect(page).to have_content 'Valor por hora extra não é um número'
  end
  context 'Usuário Cliente cadastra um preço-base' do
    it 'sem permissão' do
      client = User.create!(role: 'client', name: 'Janne', individual_registration: '23361142083', email: 'jsne@email.com', password: 'password')
      buffet_owner = User.create!(role: 'buffet_owner', email: 'joane@email.com', password: 'password')
      buffet = buffet_owner.create_buffet!(
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
      login_as(client)

      visit new_event_type_base_price_path(event_type)
  
      expect(current_path).to eq root_path
      expect(page).to have_content 'Você não tem permissão para acessar essa página.'
    end
  end
end