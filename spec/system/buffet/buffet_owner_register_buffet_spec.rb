require 'rails_helper'

describe 'Cadastro de buffet:' do
  context 'Usuário Dono de Buffet cadastra' do
    it 'a partir da tela de sign in' do
      user = User.create!(role: 'buffet_owner', email: 'jnne@email.com', password: 'password')
      login_as(user)
      
      visit new_buffet_path
      
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
    end
    it 'com sucesso' do
      user = User.create!(role: 'buffet_owner', email: 'jnne@email.com', password: 'password')
      login_as(user)
      
      visit new_buffet_path
      
      fill_in 'Razão Social', with: 'Buffet Estrela Dourada Ltda'
      fill_in 'Nome Fantasia', with: 'Buffet Estrela Dourada Eventos'
      fill_in 'CNPJ', with: '12345678000190'
      fill_in 'Telefone', with: '1198765-4321'
      fill_in 'E-mail', with: 'contato@estreladouradaeventos.com.br'
      fill_in 'Endereço', with: 'Rua das Flores, 123'
      fill_in 'Bairro', with: 'Centro'
      fill_in 'CEP', with: '12345678'
      fill_in 'Cidade', with: 'Cidade Luz'
      fill_in 'Estado', with: 'São Paulo'
      fill_in 'Descrição', with: 'O Buffet Eventos Estrela Dourada é um lugar mágico onde seus sonhos se tornam realidade. Com ambientes elegantes e serviços de alta qualidade, estamos prontos para tornar seu evento inesquecível.'
      fill_in 'Meios de Pagamento', with: 'Cartões de crédito, débito, transferência bancária, Pix e dinheiro.'
      click_on 'Cadastrar Buffet'
      
      expect(page).to have_content 'Buffet cadastrado com sucesso!'
      expect(page).to have_content 'Informações do Buffet'
      expect(page).to have_content 'Razão Social: Buffet Estrela Dourada Ltda'
      expect(page).to have_content 'Nome Fantasia: Buffet Estrela Dourada Eventos'
      expect(page).to have_content 'CNPJ: 12345678000190'
      expect(page).to have_content 'Telefone: 1198765-4321'
      expect(page).to have_content 'E-mail: contato@estreladouradaeventos.com.br'
      expect(page).to have_content 'Endereço: Rua das Flores, 123'
      expect(page).to have_content 'Bairro: Centro'
      expect(page).to have_content 'CEP: 12345678'
      expect(page).to have_content 'Cidade: Cidade Luz'
      expect(page).to have_content 'Estado: São Paulo'
      expect(page).to have_content 'Descrição: O Buffet Eventos Estrela Dourada é um lugar mágico onde seus sonhos se tornam realidade. Com ambientes elegantes e serviços de alta qualidade, estamos prontos para tornar seu evento inesquecível.'
      expect(page).to have_content 'Meios de Pagamento: Cartões de crédito, débito, transferência bancária, Pix e dinheiro.'
      expect(page).to have_link 'Editar Informações'
    end
    it 'com dados incompletos' do
      user = User.create!(role: 'buffet_owner', email: 'jnne@email.com', password: 'password')
      login_as(user)
  
      visit new_buffet_path
      click_on 'Cadastrar Buffet'
  
      expect(page).to have_content 'Buffet não cadastrado'
      expect(page).to have_content 'Razão Social não pode ficar em branco'
      expect(page).to have_content 'Nome Fantasia não pode ficar em branco'
      expect(page).to have_content 'CNPJ não pode ficar em branco'
      expect(page).to have_content 'Telefone não pode ficar em branco'
      expect(page).to have_content 'E-mail não pode ficar em branco'
      expect(page).to have_content 'Endereço não pode ficar em branco'
      expect(page).to have_content 'Bairro não pode ficar em branco'
      expect(page).to have_content 'CEP não pode ficar em branco'
      expect(page).to have_content 'Cidade não pode ficar em branco'
      expect(page).to have_content 'Estado não pode ficar em branco'
      expect(page).to have_content 'Descrição não pode ficar em branco'
      expect(page).to have_content 'Meios de Pagamento não pode ficar em branco'
    end
  end
  context 'Usuário Cliente cadastra buffet' do
    it 'sem permissão' do
      user = User.create!(role: 'client', name: 'Janne', individual_registration: '23361142083', email: 'jsne@email.com', password: 'password')
      login_as(user)

      visit new_buffet_path
  
      expect(current_path).to eq root_path
      expect(page).to have_content 'Você não tem permissão para acessar essa página.'
    end
  end
end
