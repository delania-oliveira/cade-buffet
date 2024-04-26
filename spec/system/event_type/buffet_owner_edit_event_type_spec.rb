require 'rails_helper'

describe 'Dono de Buffet edita o tipo de evento' do
  it 'a partir da página de detalhes' do
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
    click_on 'Ver Detalhes'
    click_on 'Editar Informações'

    expect(page).to have_content 'Editar Evento'
    expect(page).to have_field 'Nome do evento'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Capacidade mínima de pessoas'
    expect(page).to have_field 'Capacidade máxima de pessoas'
    expect(page).to have_field 'Duração em minutos'
    expect(page).to have_field 'Tipo de cardápio'
    expect(page).to have_checked_field 'Aceita endereço indicado pelo contratante'
    expect(page).to have_unchecked_field 'Bebidas alcoólicas'
    expect(page).to have_checked_field 'Decoração'
    expect(page).to have_checked_field 'Serviço de Estacionamento/Valet'
    expect(page).to have_unchecked_field 'Realizado exclusivamente no endereço do buffet'
    expect(page).to have_checked_field 'Aceita endereço indicado pelo contratante'
    expect(page).to have_button 'Salvar alterações'
  end
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
    
    visit edit_event_type_path(event_type)
    fill_in 'Duração em minutos', with: 260
    click_on 'Salvar alterações'

    expect(page).to have_content 'Evento atualizado com sucesso'
    expect(page).to have_content 'Duração em minutos: 260'
  end 
  it 'e mantem os campos obrigátorios' do
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
    
    visit edit_event_type_path(event_type)
    fill_in 'Duração em minutos', with: ''
    click_on 'Salvar alterações'

    expect(page).to have_content 'Não foi possível atualizar o Evento'
  end
  it 'e é unico capaz de editar os dados do seu próprio evento' do
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
    login_as(second_user)
    
    visit edit_event_type_path(event_type)

    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não tem permissão para acessar essa página.'
    
  end
  context 'Usuário Cliente edita um tipo de evento' do
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

      visit edit_event_type_path(event_type)
  
      expect(current_path).to eq root_path
      expect(page).to have_content 'Você não tem permissão para acessar essa página.'
    end
  end
end