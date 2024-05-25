# README

## Cadê Buffet?
#### Descrição do Projeto
Organizar uma confraternização, seja uma festa, casamento ou evento corporativo, pode ser desafiador devido às diversas necessidades envolvidas, como alimentação, espaço e organização. Para lidar com essas demandas, muitas vezes é necessário contratar um buffet, uma empresa especializada em organizar eventos completos.

Contudo, encontrar o buffet ideal para cada tipo de evento pode ser difícil. É nesse contexto que surge o projeto Cadê Buffet?

#### Objetivo
O Cadê Buffet? tem como objetivo facilitar a busca e a contratação de buffets para diferentes tipos de eventos, conectando donos de buffets com pessoas que precisam de seus serviços.

## Visualização de Telas 

| | |
|:-------------------------:|:-------------------------:|
|<img src="/screenshots/home.png" width="100%" alt="home"/> | <img src="/screenshots/signup.png" width="100%" alt="signup"/>|
|<img src="/screenshots/event-details.png" width="100%" alt="event-details"/> | <img src="/screenshots/buffet-details.png" width="100%" alt="event-details"/>|  
|<img src="/screenshots/orders.png" width="100%" alt="orders"/> | <img src="/screenshots/order-details.png" width="100%" alt="order-details"/>| 


## Instalando e Rodando o projeto

* Versão do Ruby: 3.2.2
* Instalar projeto: 
  ```bash
  bundle install
  bundle exec rake assets:precompile
  rails db:migrate db:seed
  ```
* Rodar o projeto: `bin/dev`
* Rodar o projeto para uso da API: `rails server`
* Rodar os testes: `rspec`

## API Endpoints

### Listagem de Buffets

**Endpoint:** `GET /api/v1/buffets`

**Descrição:** Este endpoint retorna uma lista de todos os buffets disponíveis.

**Parâmetros:**

- Não há parâmetros necessários para este endpoint.

**Respostas:**

- `200 OK`: A operação foi bem-sucedida. A resposta será uma lista de objetos `buffet`, cada um com os seguintes campos:
  - `id`: O ID do buffet.
  - `brand_name`: O nome fantasia do buffet
  - `telephone`: O telefone de contato do buffet,
  - `email`: O e-mail de contato do buffet
  - `address`: O endereço do buffet
  - `district`: O bairro onde está localizado o buffet
  - `cep`: O CEP do buffet
  - `city`: A cidade onde está localizada o buffet
  - `state`: O estado onde está localizado o buffet
  - `description`: A descrição do buffet
  - `payment_methods`: Os meios de pagamento que o buffet aceita

### Detalhes de um buffet

**Endpoint:** `GET /api/v1/buffets/:id`

**Descrição:** Este endpoint retorna os detalhes de um buffet específico.

**Parâmetros:**

- `id`: O ID do buffet. Deve ser um número inteiro.

**Respostas:**

- `200 OK`: A operação foi bem-sucedida. A resposta será um objeto `buffet` com os seguintes campos:
  - `id`: O ID do buffet.
  - `brand_name`: O nome fantasia do buffet
  - `telephone`: O telefone de contato do buffet,
  - `email`: O e-mail de contato do buffet
  - `address`: O endereço do buffet
  - `district`: O bairro onde está localizado o buffet
  - `cep`: O CEP do buffet
  - `city`: A cidade onde está localizada o buffet
  - `state`: O estado onde está localizado o buffet
  - `description`: A descrição do buffet
  - `payment_methods`: Os meios de pagamento que o buffet aceita
- `404 Not Found`: Se o buffet especificado não existir.

### Buscar um Buffet pelo nome

**Endpoint:** `GET /api/v1/buffets/search?query=name`

**Descrição:** Este endpoint retorna uma lista de buffets que correspondem ao nome fornecido.

**Parâmetros:**

- `name`: O nome do buffet. Deve ser uma string.

**Respostas:**

- `200 OK`: A operação foi bem-sucedida. A resposta será uma lista de objetos `buffet` que correspondem ao nome fornecido.

### Listando todos os eventos de um buffet

**Endpoint:** `GET /api/v1/buffets/:buffet_id/event_types`

**Descrição:** Este endpoint retorna uma lista de todos os tipos de eventos disponíveis para um determinado buffet.

**Parâmetros:**

- `buffet_id`: O ID do buffet.

**Respostas:**

- `200 OK`: A operação foi bem-sucedida. A resposta será uma lista de objetos `event_type`, cada um com os seguintes campos:
  - `id`: O ID do tipo de evento.
  - `name`: O nome do tipo de evento
  - `description`: Uma descrição de tipo de evento
  - `capacity_min`: O número mínimo de convidados para este tipo de evento
  - `capacity_max`: O número máximo de convidados para este tipo de evento
  - `duration`: A Duração em minutos do evento
  - `food_menu`: O cardápio do buffet
  - `alcoholic_drinks`: Se permite bebidas alcoólicas. Deve ser um tipo boolean
  - `decoration`: Se possui decoração. Deve ser um tipo boolean
  - `parking_service`: Se possui serviço de estacionamento. Deve ser um tipo boolean
  - `buffet_exclusive_address`: Se o evento é exclusivo no buffet. Deve ser um tipo boolean
  - `client_specified_address`: Se aceita outros lugares. Deve ser um tipo boolean

- `404 Not Found`: Se não existir eventos no buffet especificado, a resposta será `{ "error": "Esse buffet não possui eventos cadastrados" }`.


### Checando disponibilidade de um evento

**Endpoint:** `POST /api/v1/buffets/:buffet_id/event_types/:event_type_id/orders/check_availability`

**Descrição:** Este endpoint verifica a disponibilidade de um pedido com base na data, número de convidados e tipo de evento.

**Parâmetros:**

- `date`: A data do evento. Deve ser uma string no formato 'yyyy-mm-dd'.
- `guests`: O número de convidados para o evento. Deve ser um número inteiro.
- `event_type_id`: O ID do tipo de evento.

**Respostas:**

- `200 OK`: A operação foi bem-sucedida. A resposta pode ser uma das seguintes:
  - `{ "message": "A quantidade de convidados é maior ou menor que a quantidade mínima ou máxima suportada" }` 
  se o número de convidados não estiver dentro da capacidade do tipo de evento.
  - `{ "message": "O buffet não está disponível para essa data" }` 
  se já houver um pedido confirmado para a mesma data e tipo de evento.
  - `{ "initial_price": <preço> }` 
  se o pedido estiver disponível. O preço inicial é calculado com base no tipo de evento, número de convidados e data.
  ---
  <center>Proposto por [TreinaDev](https://treinadev.com.br/) e feito por Delania Oliveira</center>