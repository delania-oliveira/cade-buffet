require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'gera um código aleatório' do
    it 'ao criar um novo pedido' do 
      client = User.create!(role: 'client', name: 'Janne', individual_registration: '23361142083', email: 'jsne@email.com', password: 'password')
      buffet_owner  = User.create!(role: 'buffet_owner', email: 'janne@email.com', password: 'password')
      buffet = buffet_owner.create_buffet!(
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
        payment_methods: 'Pix, transferência bancária e dinheiro'
      )
      event = buffet.event_types.create!(
        name: 'Evento de confraternização',
        description: 'Um evento especial para relaxar, se divertir e estreitar laços com colegas',
        capacity_min: 100,
        capacity_max: 500,
        duration: 240,
        food_menu: 'Jantar com frutos do mar e vinhos',
        alcoholic_drinks: true,
        decoration: true,
        parking_service: false,
        buffet_exclusive_address: false,
        client_specified_address: true
      )
      event.base_prices.create!(
        title: 'De segunda a sexta-feira',
        minimum_value: 10000,
        additional_value_per_person: 150,
        extra_hour_value: 1000,
      )
      event.base_prices.create!(
        title: 'Finais de semana e feriado',
        minimum_value: 35000,
        additional_value_per_person: 250,
        extra_hour_value: 3000,
      )
      login_as(client)
      order = client.orders.new(
        user: client,
        event_type: event, 
        date: '2024-12-25', 
        guests: 150, 
        details: 'Evento de confraternização de fim de ano da empresa ABC Corp., incluindo jantar e entretenimento ao vivo.',
        location: 'Rua das Palmeiras, 500, Bairro Jardim Tropical, Cidade Sol, São Paulo'
      )
                    
      order.save!
      
      expect(order.code).not_to be_empty
      expect(order.code.length).to eq 8
    end
    it 'e o código é único' do 
      client = User.create!(role: 'client', name: 'Janne', individual_registration: '23361142083', email: 'jsne@email.com', password: 'password')
      buffet_owner = User.create!(role: 'buffet_owner', email: 'janne@email.com', password: 'password')
      buffet = buffet_owner.create_buffet!(
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
        payment_methods: 'Pix, transferência bancária e dinheiro'
      )
      event = buffet.event_types.create!(
        name: 'Evento de confraternização',
        description: 'Um evento especial para relaxar, se divertir e estreitar laços com colegas',
        capacity_min: 100,
        capacity_max: 500,
        duration: 240,
        food_menu: 'Jantar com frutos do mar e vinhos',
        alcoholic_drinks: true,
        decoration: true,
        parking_service: false,
        buffet_exclusive_address: false,
        client_specified_address: true
      )
      event.base_prices.create!(
        title: 'De segunda a sexta-feira',
        minimum_value: 10000,
        additional_value_per_person: 150,
        extra_hour_value: 1000,
      )
      event.base_prices.create!(
        title: 'Finais de semana e feriado',
        minimum_value: 35000,
        additional_value_per_person: 250,
        extra_hour_value: 3000,
      )
      login_as(client)
      first_order = client.orders.create!(
        user: client,
        event_type: event,
        date: '2024-12-25',
        guests: 150,
        details: 'Evento de confraternização de fim de ano da empresa ABC Corp., incluindo jantar e entretenimento ao vivo.',
        location: 'Rua das Palmeiras, 500, Bairro Jardim Tropical, Cidade Sol, São Paulo'
      )
      second_order = client.orders.new(
        user: client,
        event_type: event,
        date: '2024-11-15',
        guests: 150,
        details: 'Evento de confraternização de fim de ano da empresa ABC Corp., incluindo jantar e entretenimento ao vivo.',
        location: 'Rua das Palmeiras, 500, Bairro Jardim Tropical, Cidade Sol, São Paulo'
      )

      second_order.save!
       
      expect(second_order.code).not_to eq first_order.code
    end
    context '#valid?' do
      it 'deve ter um código' do
        client = User.create!(role: 'client', name: 'Janne', individual_registration: '23361142083', email: 'jsne@email.com', password: 'password')
        buffet_owner = User.create!(role: 'buffet_owner', email: 'janne@email.com', password: 'password')
        buffet = buffet_owner.create_buffet!(
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
          payment_methods: 'Pix, transferência bancária e dinheiro'
        )
        event = buffet.event_types.create!(
          name: 'Evento de confraternização',
          description: 'Um evento especial para relaxar, se divertir e estreitar laços com colegas',
          capacity_min: 100,
          capacity_max: 500,
          duration: 240,
          food_menu: 'Jantar com frutos do mar e vinhos',
          alcoholic_drinks: true,
          decoration: true,
          parking_service: false,
          buffet_exclusive_address: false,
          client_specified_address: true
        )
        event.base_prices.create!(
          title: 'De segunda a sexta-feira',
          minimum_value: 10000,
          additional_value_per_person: 150,
          extra_hour_value: 1000,
        )
        event.base_prices.create!(
          title: 'Finais de semana e feriado',
          minimum_value: 35000,
          additional_value_per_person: 250,
          extra_hour_value: 3000,
        )
        login_as(client)
        order = client.orders.new(
          user: client,
          event_type: event, 
          date: '2024-12-25', 
          guests: 150, 
          details: 'Evento de confraternização de fim de ano da empresa ABC Corp., incluindo jantar e entretenimento ao vivo.',
          location: 'Rua das Palmeiras, 500, Bairro Jardim Tropical, Cidade Sol, São Paulo'
        )
        
        expect(order.valid?).to be true
      end
    end
  end
end
              