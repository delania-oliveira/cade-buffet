def login(user)
  click_on 'Entrar'
  select user.role, from: 'Tipo de Conta'
  fill_in 'E-mail', with: user.email
  fill_in 'Senha', with: user.password
  within('form') do
    click_on 'Entrar'
  end
end