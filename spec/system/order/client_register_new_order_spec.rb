require 'rails_helper'

describe 'Usuário cliente' do
  it 'vê botão para contratar buffet' do
    client = User.create!(role: 'client', name: 'Janne', individual_registration: '23361142083', email: 'jsne@email.com', password: 'password')
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
      payment_methods: 'Pix, transferência bancária e dinheiro'
    )
    event = buffet.event_types.create!(
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
    event.base_prices.create!(
      title: 'De segunda a sexta-feira',
      minimum_value: 10000,
      additional_value_per_person: 150,
      extra_hour_value: 1000,
    )
    event.base_prices.create!(
      title: 'Finais de semana e feriado',
      minimum_value: 35000,
      additional_value_per_person: 250,
      extra_hour_value: 3000,
    )
    login_as(client)

    visit event_type_path(buffet)

    expect(page).to have_link 'Contratar Evento'
  end
  it 'e vê o formulário de novo pedido' do
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
    event.base_prices.create!(
      title: 'De segunda a sexta-feira',
      minimum_value: 10000,
      additional_value_per_person: 150,
      extra_hour_value: 1000,
    )
    event.base_prices.create!(
      title: 'Finais de semana e feriado',
      minimum_value: 35000,
      additional_value_per_person: 250,
      extra_hour_value: 3000,
    )
    login_as(client)

    visit new_event_type_order_path(event)

    expect(page).to have_content buffet.brand_name
    expect(page).to have_content event.name
    expect(page).to have_content 'Novo Pedido'
    expect(page).to have_field 'Data do evento'
    expect(page).to have_field 'Quantidade estimada de convidados'
    expect(page).to have_field 'Detalhes do evento'
    expect(page).to have_field 'Endereço do evento'
    expect(page).to have_button 'Fazer pedido'
  end
  it 'e faz pedido com sucesso' do
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
      title: 'De segunda a sexta-feira',
      minimum_value: 10000,
      additional_value_per_person: 150,
      extra_hour_value: 1000,
    )
    event.base_prices.create!(
      title: 'Finais de semana e feriado',
      minimum_value: 35000,
      additional_value_per_person: 250,
      extra_hour_value: 3000,
    )
    
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ABCD1234')
    
    login_as(client)
    visit new_event_type_order_path(event)
    fill_in 'Data do evento', with: '2024-06-06'
    fill_in 'Quantidade estimada de convidados', with: 150
    fill_in 'Detalhes do evento', with: 'Evento de confraternização de fim de ano da empresa ABC Corp., incluindo jantar e entretenimento ao vivo.'
    fill_in 'Endereço do evento', with: 'Rua das Palmeiras, 500, Bairro Jardim Tropical, Cidade Sol, São Paulo'
    click_on 'Fazer pedido'

    expect(page).to have_content 'Pedido realizado com sucesso'
    expect(page).to have_content "Pedido: #{Order.last.code}"
    expect(page).to have_content "Status: Aguardando avaliação do buffet"
    expect(page).to have_content "Nome: #{client.name}"
    expect(page).to have_content "Data do pedido: #{Order.last.created_at.strftime("%d/%m/%Y")}"
    expect(page).to have_content 'Detalhes'
    expect(page).to have_content "Nome do buffet: #{buffet.brand_name}"
    expect(page).to have_content "Tipo de evento: #{event.name}"
    expect(page).to have_content "Data do evento: #{Order.last.date.strftime("%d/%m/%Y")}"
    expect(page).to have_content 'Quantidade estimada de convidados: 150'
    expect(page).to have_content 'Detalhes do evento: Evento de confraternização de fim de ano da empresa ABC Corp., incluindo jantar e entretenimento ao vivo.'
    expect(page).to have_content 'Endereço do evento: Rua das Palmeiras, 500, Bairro Jardim Tropical, Cidade Sol, São Paulo'
  end
  it 'e faz pedido com dados incompletos' do
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
      title: 'De segunda a sexta-feira',
      minimum_value: 10000,
      additional_value_per_person: 150,
      extra_hour_value: 1000,
    )
    event.base_prices.create!(
      title: 'Finais de semana e feriado',
      minimum_value: 35000,
      additional_value_per_person: 250,
      extra_hour_value: 3000,
    )
    
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ABCD1234')
    
    login_as(client)
    visit new_event_type_order_path(event)
    click_on 'Fazer pedido'

    expect(page).to have_content 'Pedido não pôde ser realizado'
    expect(page).to have_content 'Data do evento não pode ficar em branco'
    expect(page).to have_content 'Quantidade estimada de convidados não pode ficar em branco'
    expect(page).to have_content 'Detalhes do evento não pode ficar em branco'
    expect(page).to have_content 'Endereço do evento não pode ficar em branco'
  end
end