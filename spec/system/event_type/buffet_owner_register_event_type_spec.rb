require 'rails_helper'

describe 'Dono de buffet cadastra um tipo de evento' do
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
    login_as(user)
    
    visit buffet_path(buffet)
    click_on 'Criar Evento'
    
    fill_in 'Nome do evento', with: 'Evento Corporativo'
    fill_in 'Descrição', with: 'Um evento de networking para profissionais da área.'
    fill_in 'Capacidade mínima de pessoas', with: '30'
    fill_in 'Capacidade máxima de pessoas', with: '100'
    fill_in 'Duração em minutos', with: '120'
    fill_in 'Tipo de cardápio', with: 'Coquetel e canapés'
    check 'Bebidas alcoólicas'
    check 'Decoração'
    uncheck 'Serviço de Estacionamento/Valet'
    check 'Realizado exclusivamente no endereço do buffet'
    uncheck 'Aceita endereço indicado pelo contratante'
    click_on 'Cadastrar Evento'
    

    expect(current_path).to eq event_type_path(EventType.last)
    expect(page).to have_content 'Evento cadastrado com sucesso!'
    expect(page).to have_content 'Detalhes do Evento'
    expect(page).to have_content 'Nome do evento: Evento Corporativo'
    expect(page).to have_content 'Descrição: Um evento de networking para profissionais da área.'
    expect(page).to have_content 'Capacidade mínima de pessoas: 30'
    expect(page).to have_content 'Capacidade máxima de pessoas: 100'
    expect(page).to have_content 'Duração em minutos: 120'
    expect(page).to have_content 'Tipo de cardápio: Coquetel e canapés'
    expect(page).to have_content 'Serviços Oferecidos:'
    expect(page).to have_content 'Bebidas alcoólicas'
    expect(page).to have_content 'Decoração'
    expect(page).not_to have_content 'Serviço de Estacionamento/Valet'
    expect(page).to have_content 'Flexibilidade de local: Realizado exclusivamente no endereço do buffet'
    expect(page).not_to have_content 'Aceita endereço indicado pelo contratante'
    
    expect(page).to have_link 'Editar Informações'
    expect(page).to have_link 'Voltar'
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
    login_as(user)
    
    visit buffet_path(buffet)
    click_on 'Criar Evento'
    click_on 'Cadastrar Evento'

    expect(page).to have_content 'Evento não cadastrado'
    expect(page).to have_content 'Nome do evento não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'Capacidade mínima de pessoas não pode ficar em branco'
    expect(page).to have_content 'Capacidade máxima de pessoas não pode ficar em branco'
    expect(page).to have_content 'Duração em minutos não pode ficar em branco'
    expect(page).to have_content 'Tipo de cardápio não pode ficar em branco'
    expect(page).to have_content 'Marque pelo menos uma opção de serviço'
    expect(page).to have_content 'Marque pelo menos uma opção de localização'
    
  end
  context 'Usuário Cliente cadastra um tipo de evento' do
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

      login_as(client)

      visit new_event_type_path(buffet)
  
      expect(current_path).to eq root_path
      expect(page).to have_content 'Você não tem permissão para acessar essa página.'
    end
  end
end