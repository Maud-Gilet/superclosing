puts 'Deleting all Operations and Investments'

Investment.destroy_all
Operation.destroy_all

puts 'Deleting all Roles'
Role.destroy_all

puts 'Deleting all Users'
User.destroy_all

puts 'Creating 2 Users (operationals in Demo Company) .....'

new_users = [
  { gender: "Mme",
    first_name: 'Maud',
    last_name: 'Gilet',
    address: '16 rue du Sentier 75002 Paris',
    email: 'maud.gilet@gmail.com',
    birthday: '1992-05-20',
    password: '12345678'},
  { gender: "M.",
    first_name: 'Mathieu',
    last_name: 'Ribot',
    address: '96 rue des Moines 75017 Paris',
    email: 'mribot@hotmail.fr',
    birthday: '1984-05-30',
    password: '12345678' }
]

new_users.each do |user|
  User.create!(
    gender: user[:gender],
    first_name: user[:first_name],
    last_name: user[:last_name],
    address: user[:address],
    email: user[:email],
    birthday: user[:birthday],
    password: user[:password]
  )
end

puts 'Seeding of Users .... Finished ...................!'

puts 'Deleting all Companies'

Company.destroy_all

puts 'Creating 1 Company for the demo ...................'

new_companies = [
  { name: 'LA BONNE PATE',
    address: '10 rue Louis Aragon - 75011 Paris',
    siren: '234145673',
    legal_form: 'SAS Société par actions simplifiée',
    fiscal_date: '2017-04-01',
    creation_date: '' ,
    logo_url: 'image/upload/v1544714375/mmm6mdfyevvorduy921o.png',
    number_of_shares: 1000,
    share_nominal_value_cents: 100,
    share_nominal_value_currency: 'EUR' }
]

new_companies.each do |company|
  Company.create(
    name: company[:name],
    address: company[:address],
    siren: company[:siren],
    legal_form: company[:legal_form],
    fiscal_date: company[:fiscal_date],
    creation_date: company[:creation_date],
    number_of_shares: company[:number_of_shares],
    share_nominal_value_cents: company[:share_nominal_value_cents],
    share_nominal_value_currency: company[:share_nominal_value_currency],
  )
end

puts 'Seeding of the Company .... Finished ..................!'


puts "Creating Roles ('Président' and 'Associé' in Demo Company) ..............."

new_roles = [
  { user_id: 1,
    company_id: 1,
    category: 'Président' },
  { user_id: 2,
    company_id: 1,
    category: 'Associé' }
]

new_roles.each do |role|
  Role.create(
    user_id: role[:user_id],
    company_id: role[:company_id],
    category: role[:category]
  )
end

puts 'Seeding of Roles .... Finished ..............!'

puts 'Initializing Captable (Operation "zero") ...............'

new_captables = [
  { company_id: 1,
    category: 'initialize-captable',
    target_amount_cents: 0,
    target_amount_currency: 'EUR',
    expected_closing_date: nil,
    status: 'completed',
    premoney_cents: 0,
    premoney_currency: 'EUR',
    name: 'Initialisation de la table de capitalisation' }
]

new_captables.each do |captable|
  Operation.create(
    company_id: captable[:company_id],
    category: captable[:category],
    target_amount_cents: captable[:target_amount_cents],
    target_amount_currency: captable[:target_amount_currency],
    expected_closing_date: captable[:expected_closing_date],
    status: captable[:status],
    premoney_cents: captable[:premoney_cents],
    premoney_currency: captable[:premoney_currency],
    name: captable[:name]
  )
end

new_funding_investments = [
  { user_id: 1,
    operation_id: 1,
    number_of_shares: 700,
    share_premium_cents: 0,
    share_premium_currency: 'EUR',
    status: 'completed',
    share_nominal_value_cents: 0,
    share_nominal_value_currency: 'EUR' },
  { user_id: 2,
    operation_id: 1,
    number_of_shares: 300,
    share_premium_cents: 0,
    share_premium_currency: 'EUR',
    status: 'completed',
    share_nominal_value_cents: 0,
    share_nominal_value_currency: 'EUR' }
]

new_funding_investments.each do |investment|
  Investment.create(
    user_id: investment[:user_id],
    operation_id: investment[:operation_id],
    number_of_shares: investment[:number_of_shares],
    share_premium_cents: investment[:share_premium_cents],
    share_premium_currency: investment[:share_premium_currency],
    status: investment[:status],
    share_nominal_value_cents: investment[:share_nominal_value_cents],
    share_nominal_value_currency: investment[:share_nominal_value_currency]
  )
end

puts 'Seeding of Captables .... Finished ..............!'

puts "Creating 1 Demo Operation 'Tour d'amorçage' in demo company ..............."

# new_fundraising_operation = [
# { company_id: 1,
#   category: 'Chouquettes pour tous',
#   target_amount_cents: 12000000,
#   target_amount_currency: 'EUR',
#   expected_closing_date: 'Mon, 31 Dec 2018',
#   status: 'pending',
#   premoney_cents: 50000000,
#   premoney_currency: 'EUR',
#   name: "Tour d'amorçage" }
# ]

# new_fundraising_operation.each do |operation|
# Operation.create(
#   company_id: operation[:company_id],
#   category: operation[:category],
#   target_amount_cents: operation[:target_amount_cents],
#   target_amount_currency: operation[:target_amount_currency],
#   expected_closing_date: operation[:expected_closing_date],
#   status: operation[:status],
#   premoney_cents: operation[:premoney_cents],
#   premoney_currency: operation[:premoney_currency],
#   name: operation[:name]
# )
# end

# puts 'Seeding of the demo Operation .... Finished ..............!'

puts "Creating 3 Users for the Demo ..............."

new_investors = [
  { gender: "Mme",
    first_name: 'Hélène',
    last_name: 'Lioussou',
    address: '16 villa Gaudelet 75011 Paris',
    email: 'helene.lioussou@gmail.com',
    birthday: '1990-11-22',
    password: '12345678' },
  { gender: "M.",
    first_name: 'Jérôme',
    last_name: 'Léger',
    address: '42 Wainaku Street , Hilo, Hawai (USA)',
    email: 'jejelele12@gmail.com',
    birthday: '1964-12-06',
    password: '12345678' },
  { gender: "M.",
    first_name: 'Benjamin',
    last_name: 'Gilet',
    address: '10 rue Bachaumont 75002 Paris',
    email: 'bengilet@gmail.com',
    birthday: '1995-05-01',
    password: '12345678'}
]

new_investors.each do |investor|
  User.create!(
    gender: investor[:gender],
    first_name: investor[:first_name],
    last_name: investor[:last_name],
    address: investor[:address],
    email: investor[:email],
    birthday: investor[:birthday],
    password: investor[:password]
  )
end

# new_investors_roles = [
#   { user_id: 5,
#     company_id: 1,
#     category: 'Investisseur' },
#   { user_id: 6,
#     company_id: 1,
#     category: 'Investisseur' },
#   { user_id: 7,
#     company_id: 1,
#     category: 'Investisseur' },
#   { user_id: 8,
#     company_id: 1,
#     category: 'Investisseur' },
#   { user_id: 9,
#     company_id: 1,
#     category: 'Investisseur' },
#   { user_id: 10,
#     company_id: 1,
#     category: 'Investisseur' },
#   { user_id: 11,
#     company_id: 1,
#     category: 'Investisseur' },
#   { user_id: 12,
#     company_id: 1,
#     category: 'Investisseur' },
#   { user_id: 13,
#     company_id: 1,
#     category: 'Investisseur' },
#   { user_id: 14,
#     company_id: 1,
#     category: 'Investisseur' }
# ]

# new_investors_roles.each do |role|
#   Role.create(
#     user_id: role[:user_id],
#     company_id: role[:company_id],
#     category: role[:category]
#   )
# end

puts 'Seeding of Investors Users .... Finished ..............!'

# puts "Creating Static Documents for the demo Operation ..............."

# new_documents = [
#   { operation_id: 2,
#     title: "Pitch du tour d'amorçage",
#     category: 'Pitch',
#     date: 'Wed, 12 Dec 2018',
#     d_url: "" },
#   { operation_id: 2,
#     title: "Status à jour",
#     category: 'Status',
#     date: 'Wed, 12 Dec 2018',
#     d_url: "" },
#   { operation_id: 2,
#     title: "Kbis moins de 3 mois",
#     category: 'Kbis',
#     date: 'Wed, 12 Dec 2018',
#     d_url: "" },
# ]

# new_documents.each do |document|
#   SDocument.create(
#     operation_id: document[:operation_id],
#     title: document[:title],
#     date: document[:date],
#     d_url: document[:d_url]
#   )
# end

# puts 'Seeding of Documents .... Finished ..............!'


# puts "Creating 10 Confirmed Investments for each Investor in the demo Operation ..............."

# new_fundraising_investments = [
#   { user_id: 5,
#     operation_id: 5,
#     number_of_shares: 30,
#     share_premium_cents: 49900,
#     share_premium_currency: 'EUR',
#     status: 'confirmed',
#     share_nominal_value_cents: 100,
#     share_nominal_value_currency: 'EUR' },
#   { user_id: 6,
#     operation_id: 5,
#     number_of_shares: 24,
#     share_premium_cents: 49900,
#     share_premium_currency: 'EUR',
#     status: 'confirmed',
#     share_nominal_value_cents: 100,
#     share_nominal_value_currency: 'EUR' },
#   { user_id: 7,
#     operation_id: 5,
#     number_of_shares: 14,
#     share_premium_cents: 49900,
#     share_premium_currency: 'EUR',
#     status: 'confirmed',
#     share_nominal_value_cents: 100,
#     share_nominal_value_currency: 'EUR' },
#   { user_id: 8,
#     operation_id: 5,
#     number_of_shares: 40,
#     share_premium_cents: 49900,
#     share_premium_currency: 'EUR',
#     status: 'confirmed',
#     share_nominal_value_cents: 100,
#     share_nominal_value_currency: 'EUR' },
#   { user_id: 9,
#     operation_id: 5,
#     number_of_shares: 16,
#     share_premium_cents: 49900,
#     share_premium_currency: 'EUR',
#     status: 'confirmed',
#     share_nominal_value_cents: 100,
#     share_nominal_value_currency: 'EUR' },
#   { user_id: 10,
#     operation_id: 5,
#     number_of_shares: 24,
#     share_premium_cents: 49900,
#     share_premium_currency: 'EUR',
#     status: 'confirmed',
#     share_nominal_value_cents: 100,
#     share_nominal_value_currency: 'EUR' },
#   { user_id: 11,
#     operation_id: 5,
#     number_of_shares: 24,
#     share_premium_cents: 49900,
#     share_premium_currency: 'EUR',
#     status: 'confirmed',
#     share_nominal_value_cents: 100,
#     share_nominal_value_currency: 'EUR' },
#   { user_id: 12,
#     operation_id: 5,
#     number_of_shares: 16,
#     share_premium_cents: 49900,
#     share_premium_currency: 'EUR',
#     status: 'confirmed',
#     share_nominal_value_cents: 100,
#     share_nominal_value_currency: 'EUR' },
#   { user_id: 13,
#     operation_id: 5,
#     number_of_shares: 16,
#     share_premium_cents: 49900,
#     share_premium_currency: 'EUR',
#     status: 'confirmed',
#     share_nominal_value_cents: 100,
#     share_nominal_value_currency: 'EUR' },
#   { user_id: 14,
#     operation_id: 5,
#     number_of_shares: 14,
#     share_premium_cents: 49900,
#     share_premium_currency: 'EUR',
#     status: 'confirmed',
#     share_nominal_value_cents: 100,
#     share_nominal_value_currency: 'EUR' }
# ]

# new_fundraising_investments.each do |investment|
#   Investment.create(
#     user_id: investment[:user_id],
#     operation_id: investment[:operation_id],
#     number_of_shares: investment[:number_of_shares],
#     share_premium_cents: investment[:share_premium_cents],
#     share_premium_currency: investment[:share_premium_currency],
#     status: investment[:status],
#     share_nominal_value_cents: investment[:share_nominal_value_cents],
#     share_nominal_value_currency: investment[:share_nominal_value_currency]
#   )
# end

# puts 'Seeding of Investments .... Finished ..............!'

puts 'Seeding is .........................'
puts 'OVER ...............................'
puts '===================================='
