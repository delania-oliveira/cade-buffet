require 'rails_helper'

describe 'Usuário cria uma conta' do
  context 'Como dono de Buffet' do
    it 'e é redirecionado para formulario de criação de buffet' do
      
      visit root_path
      within 'nav' do
       click_on 'Criar uma conta'
      end
      select 'Dono de Buffet', from: 'Tipo de Conta'
      fill_in 'E-mail', with: 'jasne@email.com'
      fill_in 'Senha', with: 'janne1'
      fill_in 'Confirme sua senha', with: 'janne1'
      within 'form' do
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
      within 'form' do
        click_on 'Criar conta'
      end

      expect(page).to have_content 'E-mail não pode ficar em branco'
      expect(page).to have_content 'Senha não pode ficar em branco'

    end
  end

  context 'Como Cliente' do
    it 'e é redirecionado para tela listagem de buffets' do
      visit root_path
      within 'nav' do
       click_on 'Criar uma conta'
      end
      select 'Cliente', from: 'Tipo de Conta'
      fill_in 'Nome', with: 'Jasne'
      fill_in 'CPF', with: '73581493004'
      fill_in 'E-mail', with: 'jasne@email.com'
      fill_in 'Senha', with: 'janne1'
      fill_in 'Confirme sua senha', with: 'janne1'
      within 'form' do
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
      within 'form' do
        click_on 'Criar conta'
      end
      
      expect(page).to have_content 'Nome não pode ficar em branco'
      expect(page).to have_content 'CPF não pode ficar em branco'
      expect(page).to have_content 'E-mail não pode ficar em branco'
      expect(page).to have_content 'Senha não pode ficar em branco'
    end
  end
end