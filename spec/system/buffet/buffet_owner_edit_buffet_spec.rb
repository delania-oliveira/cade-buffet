require 'rails_helper'

describe 'Dono de Buffet edita o Buffet' do
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
    login_as(user)
    
    visit buffet_path(buffet)
    click_on 'Editar Informações'

    expect(page).to have_field 'Razão Social'
    expect(page).to have_field 'Nome Fantasia'
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'Telefone'
    expect(page).to have_field 'E-mail'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'Bairro'
    expect(page).to have_field 'CEP'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Estado'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Meios de Pagamento'
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
    login_as(user)
    
    visit buffet_path(buffet)
    click_on 'Editar Informações'
    fill_in 'Estado', with: 'Rua Vale das Flores, 123'
    click_on 'Salvar alterações'

    expect(page).to have_content 'Buffet atualizado com sucesso'
    expect(page).to have_content 'Rua Vale das Flores, 123'
  end
  it 'e mantem os campos obrigátorios' do
    user = User.create!(role: 'buffet_owner', email: 'janne@email.com', password: 'password')
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
    click_on 'Editar Informações'
    fill_in 'Estado', with: ''
    click_on 'Salvar alterações'

    expect(page).to have_content 'Não foi possível atualizar o Buffet'
  end
  it 'e é unico capaz de editar os dados do seu próprio buffet' do
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
    second_user = User.create!(role: 'buffet_owner', email: 'janene@email.com', password: 'password')
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

    visit edit_buffet_path(second_buffet)

    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não tem permissão para acessar essa página.'
  end
  context 'Usuário Cliente edita buffet' do
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

      visit edit_buffet_path(buffet)
      
      expect(current_path).to eq root_path
      expect(page).to have_content 'Você não tem permissão para acessar essa página.'
    end
  end
end