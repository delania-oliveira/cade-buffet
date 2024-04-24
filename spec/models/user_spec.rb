require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Sobre regras' do
    it 'Usuario dono de buffet só pode ter um buffet cadastrado' do 
      user = User.create!(role: 'buffet_owner', email: 'jsne@email.com', password: 'janne1')
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
      buffet = Buffet.new(
        user: user,
        corporate_name: 'Buffet Eventos Luz e Magia Ltda',
        brand_name: 'Buffet Luz e Magia Eventos',
        registration_number: '82349732000185',
        telephone:'1139484921',
        email:'contato@luzemagiaeventos.com.br',
        address: 'Avenida das Orquídeas, 3050',
        district:'Jardim das Flores',
        cep:'06755080',
        city:'Vale das Flores',
        state:'Parana',
        description:'A casa de eventos Luz e Magia oferece um espaço encantador e completo para realização de casamentos, formaturas, conferências e festas corporativas, com equipe especializada para garantir o sucesso do seu evento.',
        payment_methods: 'transferência bancária, Pix e dinheiro'
      )

      result = buffet.valid?

      expect(result).to eq false
    end
    it 'Visitante não pode se cadastrar como Cliente com CPF inválido' do
      user = User.new(role: 'client', name: 'Janne', individual_registration: '4324605036', email: 'jsne@email.com', password: 'janne1')
      
      result = user.valid?

      expect(result).to eq false
    end
  end
end
