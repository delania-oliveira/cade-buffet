# Criação de usuários client e buffet_owner
client = User.create!(role: 'client', name: 'Janne', individual_registration: '51249032016', email: 'jsne@email.com', password: 'password')
client1 = User.create!(role: 'client', name: 'Cliente1', individual_registration: '34906926088', email: 'cliente1@email.com', password: 'password')
client2 = User.create!(role: 'client', name: 'Cliente2', individual_registration: '64730798074', email: 'cliente2@email.com', password: 'password')
client3 = User.create!(role: 'client', name: 'Cliente3', individual_registration: '18530610008', email: 'cliente3@email.com', password: 'password')
buffet_owner = User.create!(role: 'buffet_owner', email: 'buffet_owner4@email.com', password: 'password')
buffet_owner1 = User.create!(role: 'buffet_owner', email: 'buffet_owner5@email.com', password: 'password')
buffet_owner2 = User.create!(role: 'buffet_owner', email: 'buffet_owner6@email.com', password: 'password')
buffet_owner3 = User.create!(role: 'buffet_owner', email: 'buffet_owner7@email.com', password: 'password')
buffet_owner4 = User.create!(role: 'buffet_owner', email: 'buffet_owner8@email.com', password: 'password')
buffet_owner5 = User.create!(role: 'buffet_owner', email: 'buffet_owner9@email.com', password: 'password')
buffet_owner6 = User.create!(role: 'buffet_owner', email: 'buffet_owner10@email.com', password: 'password')

# Criação de buffets, eventos e preço-bases
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
  title: 'De segunda à sexta',
  minimum_value: 10000,
  additional_value_per_person: 150,
  extra_hour_value: 1000,
)
event.base_prices.create!(
  title: 'Finais de semana e feriados',
  minimum_value: 35000,
  additional_value_per_person: 250,
  extra_hour_value: 3000,
)

buffet1 = buffet_owner1.create_buffet!(
  corporate_name: 'Buffet Estrela da Noite Ltda',
  brand_name: 'Estrela da Noite Eventos',
  registration_number: '98765432100001',
  telephone: '1122334455',
  email: 'contato@estreladanoite.com.br',
  address: 'Avenida das Festas, 123',
  district: 'Centro de Eventos',
  cep: '12345678',
  city: 'Cidade das Celebrações',
  state: 'São Paulo',
  description: 'O Buffet Eventos Estrela da Noite oferece uma experiência mágica em eventos noturnos. Com cardápios sofisticados e decorações deslumbrantes, transformamos sua festa em uma noite inesquecível.',
  payment_methods: 'Cartão de crédito, transferência bancária e cheque'
)
event1 = buffet1.event_types.create!(
  name: 'Baile de Gala',
  description: 'Uma noite de elegância e sofisticação para dançar até o amanhecer',
  capacity_min: 200,
  capacity_max: 1000,
  duration: 360,
  food_menu: 'Banquete com iguarias internacionais e champanhes',
  alcoholic_drinks: true,
  decoration: true,
  parking_service: true,
  buffet_exclusive_address: true,
  client_specified_address: false
)
event1.base_prices.create!(
  title: 'De segunda à sexta',
  minimum_value: 20000,
  additional_value_per_person: 200,
  extra_hour_value: 1500,
)
event1.base_prices.create!(
  title: 'Finais de semana e feriados',
  minimum_value: 50000,
  additional_value_per_person: 300,
  extra_hour_value: 2500,
)

buffet2 = buffet_owner2.create_buffet!(
  corporate_name: 'Buffet Aroma de Festa Ltda',
  brand_name: 'Aroma de Festa Buffet',
  registration_number: '12345678900002',
  telephone: '11999887766',
  email: 'contato@aromadefesta.com.br',
  address: 'Rua das Alegrias, 456',
  district: 'Zona Festiva',
  cep: '54321678',
  city: 'Cidade Alegria',
  state: 'Rio de Janeiro',
  description: 'O Buffet Aroma de Festa é especializado em eventos temáticos, trazendo aromas e sabores únicos para sua celebração. Com uma equipe criativa e menus personalizados, garantimos que seu evento seja uma festa inesquecível.',
  payment_methods: 'Dinheiro, cartão de débito e boleto bancário'
)
event2 = buffet2.event_types.create!(
  name: 'Festa Junina',
  description: 'Uma festa típica brasileira com comidas tradicionais, danças e muita animação',
  capacity_min: 50,
  capacity_max: 300,
  duration: 180,
  food_menu: 'Buffet de comidas típicas juninas e quentão',
  alcoholic_drinks: true,
  decoration: true,
  parking_service: false,
  buffet_exclusive_address: false,
  client_specified_address: true
)
event2.base_prices.create!(
  title: 'De segunda à sexta',
  minimum_value: 5000,
  additional_value_per_person: 100,
  extra_hour_value: 800,
)
event2.base_prices.create!(
  title: 'Finais de semana e feriados',
  minimum_value: 15000,
  additional_value_per_person: 200,
  extra_hour_value: 1500,
)

buffet3 = buffet_owner3.create_buffet!(
  corporate_name: 'Buffet Sabores da Terra Ltda',
  brand_name: 'Sabores da Terra Eventos',
  registration_number: '98765432100003',
  telephone: '1199887766',
  email: 'contato@saboresdaterra.com.br',
  address: 'Travessa dos Sabores, 789',
  district: 'Centro Gastronômico',
  cep: '67890123',
  city: 'Cidade Gourmet',
  state: 'Paraná',
  description: 'O Buffet Eventos Sabores da Terra valoriza a culinária regional, trazendo os melhores sabores da terra para sua festa. Com ingredientes frescos e pratos típicos, transformamos seu evento em uma experiência autêntica.',
  payment_methods: 'Transferência bancária, cartão de crédito e PayPal'
)
event3 = buffet3.event_types.create!(
  name: 'Feira Gastronômica',
  description: 'Um festival de sabores locais com chefs renomados e produtos artesanais',
  capacity_min: 100,
  capacity_max: 500,
  duration: 240,
  food_menu: 'Estações gastronômicas com pratos regionais e degustações de vinhos',
  alcoholic_drinks: true,
  decoration: true,
  parking_service: true,
  buffet_exclusive_address: true,
  client_specified_address: false
)
event3.base_prices.create!(
  title: 'De segunda à sexta',
  minimum_value: 15000,
  additional_value_per_person: 150,
  extra_hour_value: 1200,
)
event3.base_prices.create!(
  title: 'Finais de semana e feriados',
  minimum_value: 30000,
  additional_value_per_person: 200,
  extra_hour_value: 2000,
)

buffet4 = buffet_owner4.create_buffet!(
  corporate_name: 'Buffet Momentos Inesquecíveis Ltda',
  brand_name: 'Momentos Inesquecíveis Buffet',
  registration_number: '12309876500004',
  telephone: '1144556677',
  email: 'contato@momentosinesqueciveis.com.br',
  address: 'Alameda dos Sonhos, 321',
  district: 'Vila dos Casamentos',
  cep: '98761234',
  city: 'Cidade dos Sonhos',
  state: 'Bahia',
  description: 'O Buffet Momentos Inesquecíveis é especializado em casamentos e eventos românticos, proporcionando momentos mágicos para os noivos e seus convidados. Com serviços personalizados e uma equipe dedicada, transformamos seus sonhos em realidade.',
  payment_methods: 'Cartão de crédito, cheque e dinheiro'
)
event4 = buffet4.event_types.create!(
  name: 'Casamento dos Sonhos',
  description: 'Uma celebração única e emocionante para celebrar o amor e a união',
  capacity_min: 50,
  capacity_max: 300,
  duration: 300,
  food_menu: 'Banquete sofisticado com pratos gourmet e seleção de vinhos',
  alcoholic_drinks: true,
  decoration: true,
  parking_service: true,
  buffet_exclusive_address: true,
  client_specified_address: false
)
event4.base_prices.create!(
  title: 'De segunda à sexta',
  minimum_value: 25000,
  additional_value_per_person: 300,
  extra_hour_value: 2000,
)
event4.base_prices.create!(
  title: 'Finais de semana e feriados',
  minimum_value: 50000,
  additional_value_per_person: 400,
  extra_hour_value: 3000,
)
event4a = buffet4.event_types.create!(
  name: 'Renovação de Votos',
  description: 'Uma cerimônia emocionante para renovar os votos de amor e compromisso, seguida de uma recepção elegante.',
  capacity_min: 50,
  capacity_max: 200,
  duration: 240,
  food_menu: 'Buffet sofisticado com pratos gourmet e sobremesas finas',
  alcoholic_drinks: true,
  decoration: true,
  parking_service: true,
  buffet_exclusive_address: true,
  client_specified_address: false
  )

event4a.base_prices.create!(
  title: 'De segunda à sexta',
  minimum_value: 25000,
  additional_value_per_person: 300,
  extra_hour_value: 2000,
)
event4a.base_prices.create!(
  title: 'Finais de semana e feriados',
  minimum_value: 50000,
  additional_value_per_person: 400,
  extra_hour_value: 3000,
)

event4b = buffet4.event_types.create!(
  name: 'Baile de Debutante',
  description: 'Uma festa de debutante dos sonhos, com dança, música e uma atmosfera encantadora.',
  capacity_min: 100,
  capacity_max: 400,
  duration: 360,
  food_menu: 'Buffet completo com opções de pratos internacionais e coquetéis especiais',
  alcoholic_drinks: true,
  decoration: true,
  parking_service: true,
  buffet_exclusive_address: true,
  client_specified_address: false
)

event4b.base_prices.create!(
  title: 'De segunda à sexta',
  minimum_value: 25000,
  additional_value_per_person: 300,
  extra_hour_value: 2000,
)
event4b.base_prices.create!(
  title: 'Finais de semana e feriados',
  minimum_value: 50000,
  additional_value_per_person: 400,
  extra_hour_value: 3000,
)

buffet5 = buffet_owner5.create_buffet!(
  corporate_name: 'Buffet Sabor & Arte Ltda',
  brand_name: 'Sabor & Arte Eventos',
  registration_number: '8765432100005',
  telephone: '1199776655',
  email: 'contato@saborearte.com.br',
  address: 'Rua das Delícias, 1234',
  district: 'Centro Cultural',
  cep: '54321876',
  city: 'Cidade das Artes',
  state: 'Rio Grande do Sul',
  description: 'O Buffet Sabor & Arte oferece uma experiência gastronômica única, unindo sabores requintados com arte na apresentação dos pratos. Com um toque de criatividade, transformamos seu evento em uma verdadeira obra-prima.',
  payment_methods: 'Dinheiro, cartão de crédito e débito'
)
event5 = buffet5.event_types.create!(
  name: 'Noite de Degustação',
  description: 'Um evento para apreciadores da gastronomia, com menu degustação e harmonização de vinhos',
  capacity_min: 30,
  capacity_max: 100,
  duration: 180,
  food_menu: 'Menu degustação com pratos gourmet e seleção de vinhos',
  alcoholic_drinks: true,
  decoration: true,
  parking_service: false,
  buffet_exclusive_address: true,
  client_specified_address: false
)
event5.base_prices.create!(
  title: 'De segunda à sexta',
  minimum_value: 8000,
  additional_value_per_person: 150,
  extra_hour_value: 1000,
)
event5.base_prices.create!(
  title: 'Finais de semana e feriados',
  minimum_value: 15000,
  additional_value_per_person: 200,
  extra_hour_value: 1500,
)

buffet6 = buffet_owner6.create_buffet!(
  corporate_name: 'Buffet Aconchego da Fazenda Ltda',
  brand_name: 'Aconchego da Fazenda Buffet',
  registration_number: '5678901230006',
  telephone: '1188899777',
  email: 'contato@aconchegodafazenda.com.br',
  address: 'Estrada Rural, S/N',
  district: 'Fazenda Serenidade',
  cep: '76543210',
  city: 'Cidade Rural',
  state: 'Mato Grosso',
  description: 'O Buffet Aconchego da Fazenda proporciona uma experiência acolhedora em eventos ao ar livre, trazendo o clima rústico da fazenda para sua celebração. Com comida caseira e ambiente familiar, transformamos seu evento em um verdadeiro momento de tranquilidade.',
  payment_methods: 'Transferência bancária, dinheiro e boleto bancário'
)
event6 = buffet6.event_types.create!(
  name: 'Picnic na Fazenda',
  description: 'Um dia de lazer e diversão em meio à natureza, com picnic e atividades ao ar livre',
  capacity_min: 20,
  capacity_max: 100,
  duration: 360,
  food_menu: 'Cesta de picnic com quitutes da fazenda e sucos naturais',
  alcoholic_drinks: false,
  decoration: true,
  parking_service: true,
  buffet_exclusive_address: true,
  client_specified_address: false
)
event6.base_prices.create!(
  title: 'De segunda à domingo, incluindo feriados',
  minimum_value: 10000,
  additional_value_per_person: 100,
  extra_hour_value: 1500,
)

# Criação de pedidos
# conflitos de datas
# 2024-07-14, 2024-11-15, 2024-11-10, 2024-10-30, 2024-10-08, 2024-10-05
client.orders.create!(
  user: client,
  event_type: event, 
  date: '2024-12-25', 
  guests: 150, 
  details: 'Evento de confraternização de fim de ano da empresa ABC Corp., incluindo jantar e entretenimento ao vivo.',
  location: 'Rua das Palmeiras, 500, Bairro Jardim Tropical, Cidade Sol, São Paulo',
  status: 'pending'
)
client.orders.create!(
  user: client,
  event_type: event, 
  date: '2024-07-14', 
  guests: 150, 
  details: 'Evento de confraternização de fim de ano da empresa ABC Corp., incluindo jantar e entretenimento ao vivo.',
  location: 'Rua das Palmeiras, 500, Bairro Jardim Tropical, Cidade Sol, São Paulo',
  status: 'confirmed'
)
client2.orders.create!(
  user: client2,
  event_type: event, 
  date: '2024-11-15', 
  guests: 150, 
  details: 'Evento de confraternização de fim de ano da empresa ABC Corp., incluindo jantar e entretenimento ao vivo.',
  location: 'Rua das Palmeiras, 500, Bairro Jardim Tropical, Cidade Sol, São Paulo',
  status: 'confirmed'
)
client1.orders.create!(
  user: client1,
  event_type: event1, 
  date: '2024-10-16', 
  guests: 150, 
  details: 'Evento de confraternização de fim de ano da empresa ABC Corp., incluindo jantar e entretenimento ao vivo.',
  location: 'Rua das Palmeiras, 500, Bairro Jardim Tropical, Cidade Sol, São Paulo',
  status: 'waiting'
)

client3.orders.create!(
  user: client3,
  event_type: event5,
  date: '2024-12-05',
  guests: 250,
  details: 'Casamento de Maria e João, com buffet completo e música ao vivo.',
  location: 'Fazenda São João, Estrada do Campo, S/N, Zona Rural, Cidade Feliz, Rio Grande do Sul',
  status: 'waiting'
)

client2.orders.create!(
  user: client2,
  event_type: event5,
  date: '2024-11-10',
  guests: 80,
  details: 'Aniversário de 50 anos de Joana, com comida típica italiana e decoração temática.',
  location: 'Restaurante La Dolce Vita, Rua das Flores, 100, Bairro Bella Vista, Cidade Bella, São Paulo',
  status: 'confirmed'
)

client2.orders.create!(
  user: client2,
  event_type: event6,
  date: '2024-09-20',
  guests: 120,
  details: 'Evento corporativo da empresa XYZ Ltda., com coffee break e palestras.',
  location: 'Centro de Convenções ABC, Avenida Principal, 789, Bairro Centro, Cidade Central, Minas Gerais',
  status: 'waiting'
)

client1.orders.create!(
  user: client1,
  event_type: event4,
  date: '2024-10-30',
  guests: 300,
  details: 'Festa de Halloween para famílias, com atividades para crianças e buffet de doces temáticos.',
  location: 'Parque das Abóboras, Praça da Assombração, 13, Bairro Assustador, Cidade das Bruxas, Paraná',
  status: 'confirmed'
)

client1.orders.create!(
  user: client1,
  event_type: event2,
  date: '2024-11-15',
  guests: 70,
  details: 'Jantar romântico para comemorar aniversário de namoro, com menu degustação e vinho.',
  location: 'Restaurante Vista Panorâmica, Av. das Estrelas, 2000, Bairro Romance, Cidade do Amor, Rio de Janeiro',
  status: 'waiting'
)

client2.orders.create!(
  user: client2,
  event_type: event2,
  date: '2024-10-08',
  guests: 200,
  details: 'Festa de inauguração da nova filial da empresa ABC Ltda., com coquetel e música ao vivo.',
  location: 'Av. das Empresas, 123, Bairro dos Negócios, Cidade Empresarial, São Paulo',
  status: 'confirmed'
)

client3.orders.create!(
  user: client3,
  event_type: event3,
  date: '2024-11-25',
  guests: 150,
  details: 'Almoço de família para celebrar o feriado de Ação de Graças, com pratos tradicionais e sobremesas caseiras.',
  location: 'Casa da Vovó, Rua das Memórias, 789, Bairro Nostalgia, Cidade da Família, Minas Gerais',
  status: 'waiting'
)

client3.orders.create!(
  user: client3,
  event_type: event5,
  date: '2024-09-15',
  guests: 100,
  details: 'Evento de lançamento de livro, com coquetel e sessão de autógrafos.',
  location: 'Livraria Letras & Leituras, Praça do Saber, 456, Bairro Literário, Cidade das Letras, Rio Grande do Sul',
  status: 'pending'
)

client3.orders.create!(
  user: client3,
  event_type: event6,
  date: '2024-12-20',
  guests: 80,
  details: 'Festa de Natal para funcionários da empresa, com jantar e troca de presentes.',
  location: 'Salão de Festas da Empresa, Av. dos Trabalhadores, 567, Bairro Corporativo, Cidade Trabalho, Paraná',
  status: 'waiting'
)

client2.orders.create!(
  user: client2,
  event_type: event4,
  date: '2024-10-05',
  guests: 120,
  details: 'Evento de networking para profissionais da área de tecnologia, com palestras e happy hour.',
  location: 'Centro de Eventos TecnoHub, Rua da Inovação, 321, Bairro Tecnológico, Cidade Inovadora, São Paulo',
  status: 'confirmed'
)
