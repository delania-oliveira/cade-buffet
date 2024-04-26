require 'rails_helper'

describe 'Visualização do Buffet:' do
  context 'Usuário Dono de Buffet vê buffet cadastrado' do
    it 'a partir do sign in' do
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
      
      expect(page).to have_content 'Informações do Buffet'
      expect(page).to have_content 'Razão Social: Buffet Estrela Dourada Ltda'
      expect(page).to have_content 'Nome Fantasia: Buffet Estrela Dourada Eventos'
      expect(page).to have_content 'CNPJ: 12345678000190'
      expect(page).to have_content 'Telefone: 11987654321'
      expect(page).to have_content 'E-mail: contato@estreladouradaeventos.com.br'
      expect(page).to have_content 'Endereço: Rua das Flores, 123'
      expect(page).to have_content 'Bairro: Centro'
      expect(page).to have_content 'CEP: 12345678'
      expect(page).to have_content 'Cidade: Cidade Luz'
      expect(page).to have_content 'Estado: São Paulo'
      expect(page).to have_content 'Descrição: O Buffet Eventos Estrela Dourada é um lugar mágico onde seus sonhos se tornam realidade. Com ambientes elegantes e serviços de alta qualidade, estamos prontos para tornar seu evento inesquecível'
      expect(page).to have_content 'Meios de Pagamento: Cartões de crédito, débito, transferência bancária, Pix e dinheiro'
      expect(page).to have_link 'Editar Informações'
    end
    it 'e não vê o botão "Editar Informações" na página de outro buffet' do
      user = User.create!(role: 'buffet_owner', email: 'joane@email.com', password: 'password')
      user.create_buffet!(
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
      login_as(user)
  
      visit buffet_path(second_buffet)
  
      expect(page).not_to have_link 'Editar Informações'
    end
  end
  context 'Visitante vê buffet cadastrado' do
    it 'e vê detalhes do buffet' do
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
      
      visit root_path
      click_on 'Buffet Harmonia dos Sabores Eventos'

      expect(current_path).to eq buffet_path(buffet)
      expect(page).to  have_content 'Buffet Harmonia dos Sabores Eventos'
      expect(page).to  have_content 'O Buffet Eventos Harmonia dos Sabores proporciona uma combinação única de sabores e experiências para seu evento. Com menus personalizados e um ambiente acolhedor, estamos prontos para fazer do seu evento um verdadeiro sucesso.'
      expect(page).to  have_content 'CNPJ: 13579246000190'
      expect(page).to  have_content 'Telefone: 1133334444'
      expect(page).to  have_content 'E-mail: contato@harmoniadosabores.com.br'
      expect(page).to  have_content 'Endereço: Rua das Delícias, 789 - Vila Gastronômica'
      expect(page).to  have_content 'CEP: 98765432'
      expect(page).to  have_content 'Cidade: Cidade dos Sabores'
      expect(page).to  have_content 'Estado: Minas Gerais'
      expect(page).to  have_content 'Meios de Pagamento: Cartões de crédito, débito, transferência bancária e dinheiro'
      expect(page).not_to  have_link 'Editar Informações'
      expect(page).not_to  have_link 'Criar Evento'
    end
    it 'e vê todos os tipos de festas disponíveis' do
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
      buffet.event_types.create!(
        name: 'Conferência de Negócios',
        description: 'Uma conferência para discutir estratégias e tendências de negócios.',
        capacity_min: 50,
        capacity_max: 300,
        duration: 180,
        food_menu: 'Coffee break e almoço executivo',
        alcoholic_drinks: false,
        decoration: true,
        parking_service: true,
        buffet_exclusive_address: false,
        client_specified_address: true
      )
      buffet.event_types.create!(
        name: 'Workshop de Arte',
        description: 'Um workshop para explorar técnicas de pintura e expressão artística.',
        capacity_min: 20,
        capacity_max: 50,
        duration: 120,
        food_menu: 'Lanches leves e bebidas',
        alcoholic_drinks: false,
        decoration: true,
        parking_service: false,
        buffet_exclusive_address: true,
        client_specified_address: false
      )
      buffet.event_types.create!(
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
     
      visit buffet_path(buffet)
    
      expect(page).to  have_content 'Conferência de Negócios'
      expect(page).to  have_content 'Festa de Aniversário'
      expect(page).to  have_content 'Workshop de Arte'
    end
  end
end
