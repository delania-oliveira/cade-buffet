require 'rails_helper'

describe 'Dono de Buffet edita o preço-base do evento' do
  it 'a partir da página de detalhes do evento' do
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
    base_price = event_type.base_prices.create!(
      title: 'De segunda a sexta-feira',
      minimum_value: 10000,
      additional_value_per_person: 150,
      extra_hour_value: 1000,
    )
    login_as(user)
    
    visit buffet_path(buffet)
    click_on 'Ver Detalhes', :match => :first
    click_on 'Detalhes dos valores', :match => :first
    click_on 'Editar Valores'

    expect(page).to have_content 'Editar valores do preço-base'
    expect(page).to have_field 'Título'
    expect(page).to have_field 'Valor mínimo'
    expect(page).to have_field 'Valor adicional por pessoa'
    expect(page).to have_field 'Valor por hora extra'
    expect(page).to have_button 'Salvar alterações'
  end
  it 'com sucesso' do
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
    base_price = event_type.base_prices.create!(
      title: 'De segunda a sexta-feira',
      minimum_value: 10000,
      additional_value_per_person: 150,
      extra_hour_value: 1000,
    )
    login_as(user)
    
    visit edit_base_price_path(base_price)
    fill_in 'Título', with: 'Feriados'
    click_on 'Salvar alterações'

    expect(page).to have_content 'Preço-base atualizado com sucesso'
    expect(page).to have_content 'Título: Feriados'
  end 
  it 'e mantem os campos obrigátorios' do
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
    base_price = event_type.base_prices.create!(
      title: 'De segunda a sexta-feira',
      minimum_value: 10000,
      additional_value_per_person: 150,
      extra_hour_value: 1000,
    )
    login_as(user)
    
    visit edit_base_price_path(base_price)
    fill_in 'Título', with: ''
    click_on 'Salvar alterações'

    expect(page).to have_content 'Não foi possível atualizar o preço-base'
  end
  it 'e é unico capaz de editar os dados do seu próprio evento' do
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
    base_price = event_type.base_prices.create!(
      title: 'De segunda a sexta-feira',
      minimum_value: 10000,
      additional_value_per_person: 150,
      extra_hour_value: 1000,
    )
    second_user = User.create!(role: 'buffet_owner', email: 'janne@email.com', password: 'janne1')
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
    
    visit edit_base_price_path(base_price)

    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não tem permissão para acessar essa página.'
  end
  context 'Usuário Cliente edita o preço-base' do
    it 'sem permissão' do
      client = User.create!(role: 'client', name: 'Janne', individual_registration: '23361142083', email: 'jsne@email.com', password: 'janne1')
      buffet_owner = User.create!(role: 'buffet_owner', email: 'joane@email.com', password: 'janne1')
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
      base_price = event_type.base_prices.create!(
        title: 'De segunda a sexta-feira',
        minimum_value: 10000,
        additional_value_per_person: 150,
        extra_hour_value: 1000,
      )
      login_as(client)

      visit edit_base_price_path(base_price)
  
      expect(current_path).to eq root_path
      expect(page).to have_content 'Você não tem permissão para acessar essa página.'
    end
  end
end