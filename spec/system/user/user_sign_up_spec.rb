require 'rails_helper'

describe 'Usuário cria uma conta', js: true do
  context 'Como dono de Buffet' do
    it 've o formulário' do
      
      visit root_path
      within 'nav' do
       click_on 'Criar uma conta'
      end
      select 'Dono de Buffet', from: 'Tipo de Conta'
   
      expect(page).to have_select 'Tipo de Conta'
      expect(page).not_to have_field 'Nome'
      expect(page).not_to have_field 'CPF'
      expect(page).to have_field 'E-mail'
      expect(page).to have_field 'Senha'
    end
    it 'e é redirecionado com sucesso para formulário de criação de buffet' do
      
      visit root_path
      within 'nav' do
       click_on 'Criar uma conta'
      end
      select 'Dono de Buffet', from: 'Tipo de Conta'
      fill_in 'E-mail', with: 'jasne@email.com'
      fill_in 'Senha', with: 'password'
      fill_in 'Confirme sua senha', with: 'password'
      within 'div.actions' do
        click_on 'Criar conta'
      end
    
      expect(current_path).to eq new_buffet_path
      expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso'
      expect(page).to have_button 'Sair'
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
      expect(page).to have_button 'Cadastrar Buffet'
    end
    it 'com dados incompletos' do
      visit root_path
      within 'nav' do
        click_on 'Criar uma conta'
      end
      select 'Dono de Buffet', from: 'Tipo de Conta'
      within 'div.actions' do
        click_on 'Criar conta'
      end

      expect(page).to have_content 'E-mail não pode ficar em branco'
      expect(page).to have_content 'Senha não pode ficar em branco'

    end
  end

  context 'Como Cliente' do
    it 've o formulario' do
      
      visit root_path
      within 'nav' do
       click_on 'Criar uma conta'
      end
      select 'Cliente', from: 'Tipo de Conta'
   
      expect(page).to have_select 'Tipo de Conta'
      expect(page).to have_field 'Nome'
      expect(page).to have_field 'CPF'
      expect(page).to have_field 'E-mail'
      expect(page).to have_field 'Senha'
    end
    it 'e é redirecionado com sucesso para tela listagem de buffets' do
      visit root_path
      within 'nav' do
       click_on 'Criar uma conta'
      end
      select 'Cliente', from: 'Tipo de Conta'
      fill_in 'Nome', with: 'Jasne'
      fill_in 'CPF', with: '73581493004'
      fill_in 'E-mail', with: 'jasne@email.com'
      fill_in 'Senha', with: 'password'
      fill_in 'Confirme sua senha', with: 'password'
      within 'div.actions' do
        click_on 'Criar conta'
      end
      
      expect(current_path).to eq root_path
      expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso'
      expect(page).to have_button 'Sair'
    end
    it 'com dados incompletos' do
      visit root_path
      within 'nav' do
       click_on 'Criar uma conta'
      end
      select 'Cliente', from: 'Tipo de Conta'
      within 'div.actions' do
        click_on 'Criar conta'
      end
      
      expect(page).to have_content 'Nome não pode ficar em branco'
      expect(page).to have_content 'CPF não pode ficar em branco'
      expect(page).to have_content 'E-mail não pode ficar em branco'
      expect(page).to have_content 'Senha não pode ficar em branco'
    end
  end
end