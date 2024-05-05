require 'rails_helper'

describe 'cliente' do
  it 'e vê listagem de pedidos' do
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
    
    codes = Array.new(4) { |i| "ORDERCD#{i}" }
    allow(SecureRandom).to receive(:alphanumeric).and_return(*codes)
    
    client.orders.create!(
      user: client,
      event_type: event, 
      date: '2024-12-25', 
      guests: 150, 
      details: 'Evento de confraternização de fim de ano da empresa ABC Corp., incluindo jantar e entretenimento ao vivo.',
      location: 'Rua das Palmeiras, 500, Bairro Jardim Tropical, Cidade Sol, São Paulo',
      status: 'pending'
    )
    client.orders.create!(
      user: client,
      event_type: event, 
      date: '2024-07-14', 
      guests: 150, 
      details: 'Evento de confraternização de fim de ano da empresa ABC Corp., incluindo jantar e entretenimento ao vivo.',
      location: 'Rua das Palmeiras, 500, Bairro Jardim Tropical, Cidade Sol, São Paulo',
      status: 'confirmed'
    )
    client.orders.create!(
      user: client,
      event_type: event, 
      date: '2024-11-15', 
      guests: 150, 
      details: 'Evento de confraternização de fim de ano da empresa ABC Corp., incluindo jantar e entretenimento ao vivo.',
      location: 'Rua das Palmeiras, 500, Bairro Jardim Tropical, Cidade Sol, São Paulo',
      status: 'canceled'
    )
    client.orders.create!(
      user: client,
      event_type: event, 
      date: '2024-10-16', 
      guests: 150, 
      details: 'Evento de confraternização de fim de ano da empresa ABC Corp., incluindo jantar e entretenimento ao vivo.',
      location: 'Rua das Palmeiras, 500, Bairro Jardim Tropical, Cidade Sol, São Paulo',
      status: 'waiting'
    )
    
    login_as(client)
    visit orders_path
 
    expect(page).to have_content 'Meus pedidos'
    expect(page).to have_content 'Código'
    expect(page).to have_link "ORDERCD0"
    expect(page).to have_link 'ORDERCD1'
    expect(page).to have_link 'ORDERCD2'
    expect(page).to have_link 'ORDERCD3'
    expect(page).to have_content 'Tipo de evento'
    expect(page).to have_content 'Evento de confraternização'
    expect(page).to have_content 'Data do evento'
    expect(page).to have_content '25/12/2024'
    expect(page).to have_content '14/07/2024'
    expect(page).to have_content '15/11/2024'
    expect(page).to have_content '16/10/2024'
    expect(page).to have_content 'Status'
    expect(page).to have_content 'Aguardando avaliação do buffet'
    expect(page).to have_content 'Pedido confirmado'
    expect(page).to have_content 'Pedido cancelado'
    expect(page).to have_content 'Aguardando confirmação'
  end
  it 'e vê detalhes do pedido' do
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
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCD1234')
    order_a = client.orders.create!(
      user: client,
      event_type: event, 
      date: '2024-12-25', 
      guests: 150, 
      details: 'Evento de confraternização de fim de ano da empresa ABC Corp., incluindo jantar e entretenimento ao vivo.',
      location: 'Rua das Palmeiras, 500, Bairro Jardim Tropical, Cidade Sol, São Paulo',
      status: 'pending'
    )
    allow(SecureRandom).to receive(:alphanumeric).and_call_original
    client.orders.create!(
      user: client,
      event_type: event, 
      date: '2024-07-14', 
      guests: 150, 
      details: 'Evento de confraternização de fim de ano da empresa ABC Corp., incluindo jantar e entretenimento ao vivo.',
      location: 'Rua das Palmeiras, 500, Bairro Jardim Tropical, Cidade Sol, São Paulo',
      status: 'pending'
    )

    login_as(client)
    visit orders_path
    click_on 'ABCD1234'

    expect(page).to have_content 'Pedido: ABCD1234'
    expect(page).to have_content 'Status: Aguardando avaliação do buffet'
    expect(page).to have_content "Nome: #{client.name}"
    expect(page).to have_content "Data do pedido: #{order_a.created_at.strftime("%d/%m/%Y")}"
    expect(page).to have_content 'Detalhes'
    expect(page).to have_content "Nome do buffet: #{buffet.brand_name}"
    expect(page).to have_content "Tipo de evento: #{event.name}"
    expect(page).to have_content "Data do evento: #{order_a.date.strftime("%d/%m/%Y")}"
    expect(page).to have_content 'Quantidade estimada de convidados: 150'
    expect(page).to have_content 'Detalhes do evento: Evento de confraternização de fim de ano da empresa ABC Corp., incluindo jantar e entretenimento ao vivo.'
    expect(page).to have_content 'Endereço do evento: Rua das Palmeiras, 500, Bairro Jardim Tropical, Cidade Sol, São Paulo'
  end
end