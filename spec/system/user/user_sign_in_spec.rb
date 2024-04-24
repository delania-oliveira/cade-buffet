require 'rails_helper'

describe 'Usuário se autentica' do
  context 'como Dono de Buffet' do
    it 'com sucesso' do
      User.create!(role: 'buffet_owner', email: 'jadne@email.com', password: 'janne1')
  
      visit root_path
      click_on 'Entrar'
      fill_in 'E-mail', with: 'jadne@email.com'
      fill_in 'Senha', with: 'janne1'
      within 'form' do
        click_on 'Entrar'
      end
  
      expect(page).to have_content 'Login efetuado com sucesso'
      within 'nav'do
        expect(page).not_to have_link 'Entrar'
        expect(page).to have_button 'Sair'
      end
    end
    it 'e faz logout' do
      User.create!(role: 'buffet_owner', email: 'jadne@email.com', password: 'janne1')
      
      visit root_path
      click_on 'Entrar'
      fill_in 'E-mail', with: 'jadne@email.com'
      fill_in 'Senha', with: 'janne1'
      within('form') do
        click_on 'Entrar'
      end
      click_on 'Sair'
  
      expect(page).to have_content 'Logout efetuado com sucesso'
      within('nav') do
        expect(page).to have_link 'Entrar'
        expect(page).not_to have_button 'Sair'
      end
    end
  end
  context '' do
    it 'com sucesso' do
      User.create!(role: 'client', name: 'Janne', individual_registration: '23361142083', email: 'jsne@email.com', password: 'janne1')
  
      visit root_path
      click_on 'Entrar'
      fill_in 'E-mail', with: 'jsne@email.com'
      fill_in 'Senha', with: 'janne1'
      within 'form' do
        click_on 'Entrar'
      end
  
      expect(page).to have_content 'Login efetuado com sucesso'
      within 'nav'do
        expect(page).not_to have_link 'Entrar'
        expect(page).to have_button 'Sair'
      end
    end
    it 'e faz logout' do
      User.create!(role: 'client', name: 'Janne', individual_registration: '23361142083', email: 'jsne@email.com', password: 'janne1')
      
      visit root_path
      click_on 'Entrar'
      fill_in 'E-mail', with: 'jsne@email.com'
      fill_in 'Senha', with: 'janne1'
      within('form') do
        click_on 'Entrar'
      end
      click_on 'Sair'
  
      expect(page).to have_content 'Logout efetuado com sucesso'
      within('nav') do
        expect(page).to have_link 'Entrar'
        expect(page).not_to have_button 'Sair'
      end
    end
  end
end