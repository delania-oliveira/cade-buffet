require 'rails_helper'

describe 'Visitante busca por um buffet' do
  it 'a partir da tela inicial' do
    
    visit root_path

    expect(page).to have_field 'query'
    expect(page).to have_button 'Buscar'
  end
  it 'a partir do menu' do
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
    
    visit buffet_path(buffet)

    within('header') do
      expect(page).to have_field 'query'
      expect(page).to have_button 'Buscar'
    end
  end
  it 'e encontra um buffet' do 
    user = User.create!(role: 'buffet_owner', email: 'janne@email.com', password: 'password')
    user.create_buffet!(
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
      
    visit root_path
    fill_in 'query', with: 'sabores'
    click_on 'Buscar'

    expect(page).to have_content '1 buffet encontrado para "sabores"'
    expect(page).to have_link 'Buffet Harmonia dos Sabores Eventos'
    expect(page).to have_content 'Cidade dos Sabores'
    expect(page).to have_content 'Minas Gerais'
  end
  it 'e visualiza em ordem alfabética' do
    first_user = User.create!(role: 'buffet_owner', email: 'buffet1@example.com', password: 'password')
    first_buffet = first_user.create_buffet!(
      corporate_name: 'Buffet Harmonia dos Sabores Ltda',
      brand_name: 'Buffet Harmonia dos Sabores Eventos',
      registration_number: '13579246000190',
      telephone: '1133334444',
      email: 'contato@harmoniadosabores.com.br',
      address: 'Rua das Delícias, 789',
      district: 'Vila Gastronômica',
      cep: '98765432',
      city: 'São Paulo',
      state: 'São Paulo',
      description: 'O Buffet Eventos Harmonia dos Sabores proporciona uma combinação única de sabores e experiências para seu evento. Com menus personalizados e um ambiente acolhedor, estamos prontos para fazer do seu evento um verdadeiro sucesso.',
      payment_methods: 'Cartões de crédito, débito, transferência bancária e dinheiro'
    )
    second_user =  User.create!(role: 'buffet_owner', email: 'buffet2@example.com', password: 'password')
    second_buffet = second_user.create_buffet!(
      corporate_name: 'Buffet São Paulo Ltda',
      brand_name: 'Buffet São Paulo Eventos',
      registration_number: '98765432000190',
      telephone: '11876543210',
      email: 'contato@brilhocelestial.com.br',
      address: 'Avenida das Estrelas, 456',
      district: 'Jardim Celeste',
      cep: '87654321',
      city: 'Cidade das Estrelas',
      state: 'Rio de Janeiro',
      description: 'O Buffet Eventos Brilho Celestial proporciona experiências únicas e memoráveis para tornar seu evento especial. Com uma equipe dedicada e espaços encantadores, estamos prontos para realizar seus sonhos.',
      payment_methods: 'Cartões de crédito, débito, transferência bancária e dinheiro'
    )
    third_user = User.create!(role: 'buffet_owner', email: 'buffet3@example.com', password: 'password')
    third_buffet =third_user.create_buffet!(
      corporate_name: 'Buffet Florescer das Cores Ltda',
      brand_name: 'Buffet Florescer das Cores Eventos',
      registration_number: '987654321000190',
      telephone: '1188889999',
      email: 'contato@florescerdascores.com.br',
      address: 'Avenida das Flores, 123',
      district: 'Jardim das Cores',
      cep: '50505050',
      city: 'São Paulo',
      state: 'São Paulo',
      description: 'O Buffet Eventos Florescer das Cores traz uma explosão de cores e sabores para seu evento. Com uma equipe criativa e menus personalizados, transformamos sua celebração em um verdadeiro jardim de alegria.',
      payment_methods: 'Cartões de crédito, débito, transferência bancária e dinheiro'
    )
    fourth_user = User.create!(role: 'buffet_owner', email: 'buffet4@example.com', password: 'password')
    fourth_user.create_buffet!(
      corporate_name: 'Buffet Estrela da Noite Ltda',
      brand_name: 'Buffet Estrela da Noite Eventos',
      registration_number: '135792468000190',
      telephone: '11987654321',
      email: 'contato@estreladanoiteeventos.com.br',
      address: 'Avenida da Lua, 789',
      district: 'Vila Noturna',
      cep: '13579135',
      city: 'Cidade da Noite',
      state: 'Rio Grande do Sul',
      description: 'O Buffet Eventos Estrela da Noite oferece experiências memoráveis para eventos noturnos. Com ambientes sofisticados e serviços excepcionais, tornamos suas celebrações inesquecíveis.',
      payment_methods: 'Cartões de crédito, débito, transferência bancária e dinheiro'
    )

    visit root_path
    fill_in 'query', with: 'são paulo'
    click_on 'Buscar'
    
    expect(page).to have_content '3 buffets encontrados para "são paulo"'
    expect(page.body.index(third_buffet.brand_name)).to be < page.body.index(first_buffet.brand_name)
    expect(page.body.index(first_buffet.brand_name)).to be < page.body.index(second_buffet.brand_name)
    expect(page).to have_link 'Buffet Florescer das Cores Eventos'
    expect(page).to have_link 'Buffet Harmonia dos Sabores Eventos'
    expect(page).to have_link 'Buffet São Paulo Eventos'
    expect(page).not_to have_link 'Buffet Estrela da Noite Eventos'

  end
end
