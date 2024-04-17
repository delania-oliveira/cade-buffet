require 'rails_helper'

describe 'Usuário cria uma conta' do
  it 'com sucesso' do
    visit root_path
    within 'nav' do
     click_on 'Criar uma conta'
    end
    fill_in 'E-mail', with: 'janne@email.com'
    fill_in 'Senha', with: 'janne1'
    fill_in 'Confirme sua senha', with: 'janne1'
    within 'form' do
      click_on 'Criar conta'
    end

    expect(page). to have_content 'Bem vindo! Você realizou seu registro com sucesso'
    expect(page). to have_button 'Sair'
  end
end