require 'rails_helper'

describe 'Usuario visita a tela inicial' do
  it 'e vê o nome da aplicação' do
    visit root_path

    expect(page).to have_content 'Cadê Buffet?'
  end
  it 'e vê botões para criar conta e entrar' do
    visit root_path

    within 'nav' do
      expect(page).to have_link 'Criar uma conta'
      expect(page).to have_link 'Entrar'
    end
  end
  it 'e vê a listagem de buffets' do
    first_user = User.create!(role: 'buffet_owner', email: 'joane@email.com', password: 'janne1')
    first_user.create_buffet!(
      corporate_name: 'Buffet Brilho Celestial Ltda',
      brand_name: 'Buffet Brilho Celestial Eventos',
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
    second_user = User.create!(role: 'buffet_owner', email: 'janne@email.com', password: 'janne1')
    second_user.create_buffet!(
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
    third_user = User.create!(role: 'buffet_owner', email: 'jina@email.com', password: 'janne1')
    third_user.create_buffet!(
      corporate_name: 'Buffet Sabor da Festa Ltda',
      brand_name: 'Buffet Sabor da Festa Eventos',
      registration_number: '2468013579000190',
      telephone: '1155556666',
      email: 'contato@sabordafesta.com.br',
      address: 'Rua dos Doces, 101',
      district: 'Centro Gastronômico',
      cep: '10101010',
      city: 'Cidade dos Doces',
      state: 'Bahia',
      description: 'O Buffet Eventos Sabor da Festa oferece uma explosão de sabores e alegria para seu evento. Com uma equipe apaixonada e pratos deliciosos, estamos prontos para tornar seu evento memorável.',
      payment_methods: 'Cartões de crédito, débito, transferência bancária, Pix e dinheiro'
    )

    visit root_path

    expect(page).to have_link 'Buffet Brilho Celestial Eventos'
    expect(page).to have_content 'Cidade das Estrelas'
    expect(page).to have_content 'Rio de Janeiro'
    expect(page).to have_link 'Buffet Brilho Celestial Eventos'
    expect(page).to have_content 'Cidade dos Sabores'
    expect(page).to have_content 'Minas Gerais'
    expect(page).to have_link 'Buffet Brilho Celestial Eventos'
    expect(page).to have_content 'Cidade dos Doces'
    expect(page).to have_content 'Bahia'
  end
  it 'e não existem buffets cadastrados' do
    visit root_path

    expect(page). to have_content 'Não existem Buffets cadastrados'
  end
end