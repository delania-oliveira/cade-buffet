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
end