require 'open-uri'
require 'cpf_faker'

if Rails.env.development?
  puts "Destroying DB..."

  Review.destroy_all
  Place.destroy_all
  Angel.destroy_all
  User.destroy_all
end

simple_users = []
business_users = []

puts "Creating personal users...And angels"
sleep(1)

# USERS CREATION

# position seed for testing later
# longitude = rand(23.476482..23.637696).-@.round(6)
# latitude = rand(46.540127..46.732998).-@.round(6)

user_first_names = ['Talita', 'Antonia', 'Thais', 'Andreia', 'Larissa',
                    'Aline', 'Giovanna', 'Elisa', 'Suzana', 'Tereza',
                    'Jaqueline', 'Lilian', 'Nathalia', 'Isabella', 'Sara',
                    'Daniela', 'Elsa', 'Fernanda', 'Carla', 'Lidia',
                    'Rodrigo', 'Pedro', 'Joao', 'Victor', 'Jorge']

user_last_names = ['Santos', 'Weber', 'Schmidt', 'Torres', 'Silva',
                   'Andrade', 'Barbosa', 'Barros', 'Santana', 'Marques',
                   'Campos', 'Borges', 'Moraes', 'Nogueira', 'Ferreira',
                   'Carvalho', 'Vieira', 'Rocha', 'Gentil', 'Freitas',
                   'Miranda', 'Machado', 'Lopes', 'Fernandes', 'Costa']

user_genders = ['feminino', 'feminino', 'feminino', 'feminino', 'outro',
                'feminino', 'feminino', 'feminino', 'feminino', 'outro',
                'feminino', 'feminino', 'feminino', 'feminino', 'outro',
                'feminino', 'feminino', 'feminino', 'feminino', 'outro',
                'masculino', 'masculino', 'masculino', 'masculino', 'outro']

user_avatar_url = ['https://images.pexels.com/photos/4026110/pexels-photo-4026110.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                   'https://images.pexels.com/photos/1987301/pexels-photo-1987301.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                   'https://images.pexels.com/photos/3676424/pexels-photo-3676424.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                   'https://images.pexels.com/photos/2804282/pexels-photo-2804282.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                   'https://images.pexels.com/photos/3008355/pexels-photo-3008355.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                   'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                   'https://images.pexels.com/photos/2100063/pexels-photo-2100063.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                   'https://images.pexels.com/photos/2120114/pexels-photo-2120114.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                   'https://images.pexels.com/photos/2218786/pexels-photo-2218786.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                   'https://images.pexels.com/photos/3021593/pexels-photo-3021593.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                   'https://images.pexels.com/photos/2169434/pexels-photo-2169434.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                   'https://images.pexels.com/photos/2123778/pexels-photo-2123778.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                   'https://images.pexels.com/photos/1239288/pexels-photo-1239288.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                   'https://images.pexels.com/photos/1988681/pexels-photo-1988681.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                   'https://images.pexels.com/photos/2167673/pexels-photo-2167673.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                   'https://images.pexels.com/photos/839633/pexels-photo-839633.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                   'https://images.pexels.com/photos/2104252/pexels-photo-2104252.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                   'https://images.pexels.com/photos/718978/pexels-photo-718978.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                   'https://images.pexels.com/photos/2101838/pexels-photo-2101838.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                   'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                   'https://images.pexels.com/photos/2287252/pexels-photo-2287252.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                   'https://images.pexels.com/photos/842980/pexels-photo-842980.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                   'https://images.pexels.com/photos/4484829/pexels-photo-4484829.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260',
                   'https://images.pexels.com/photos/4286948/pexels-photo-4286948.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                   'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500']

user_counter = 0
25.times do
  first_name = user_first_names[user_counter]
  last_name = user_last_names[user_counter]
  username = "#{first_name.downcase}#{%w[. _ -].sample}#{last_name.downcase}"
  email = Faker::Internet.free_email(name: username)
  password = "123456"
  city = "São Paulo"
  state = "SP"
  gender = user_genders[user_counter]
  phone_number = "#{rand(1..9)}#{rand(0..9)}9#{rand(2..9)}#{(0..9).to_a.sample(7).join}"
  cpf = rand.to_s[2..12]
  longitude = rand(23.476482..23.637696).-@.round(6)
  latitude = rand(46.540127..46.732998).-@.round(6)
  simple_user = User.create!(first_name: first_name,
                             last_name: last_name,
                             username: username,
                             email: email,
                             password: password,
                             city: city,
                             state: state,
                             cpf: cpf,
                             gender: gender,
                             phone_number: phone_number,
                             longitude: longitude,
                             latitude: latitude)

  avatar = URI.open(user_avatar_url[user_counter])
  simple_user.photo.attach(io: avatar, filename: "#{simple_user.username}.png", content_type: 'image/png')

  simple_users << simple_user
  puts "#{simple_user.username} created"
  user_counter += 1

  # ANGELS CREATION
  angel_first_names = ['Talita', 'Thais', 'Larissa', 'Aline', 'Giovanna',
                       'Nathalia', 'Isabella', 'Sara', 'Daniela', 'Fernanda',
                       'Bia', 'Heloisa', 'Carol', 'Ana', 'Bruna',
                       'Otavio', 'Thiago', 'Matheus', 'Luis', 'Davi',
                       'Mauro', 'Caio', 'Leo', 'Fred', 'Marcelo',
                       'Fabio', 'Beto', 'Pedro', 'Fabricio', 'Paulo']
  rand(1..3).times do
    phone_number = "#{rand(1..9)}#{rand(0..9)}9#{rand(2..9)}#{(0..9).to_a.sample(7).join}"
    angel_first_name = angel_first_names.sample
    angel_last_name = user_last_names.sample
    Angel.create!(first_name: angel_first_name,
                  last_name: angel_last_name,
                  email: email,
                  phone_number: phone_number,
                  user: simple_user)
  end
end

puts "Creating reviewed places..."
sleep(1)

place_names = ['Trabuca', 'Benzina', 'Ginteria', 'Tetto Rooftop', 'Tatu Bola',
               'Galleria Bar', 'Bar de Cima', 'Biri Nait', 'Vila Seu Justino', 'Vila 567',
               'Bar do Veloso', 'A Casa do Porco Bar', 'Bar do Jão', 'Chopp do Alemão', 'Bar Do Urso',
               'Morrison Rock Bar', 'Eu Tu Eles', 'Santa Julia', 'Frangó', 'Veríssimo',
               'Salve Jorge', 'Bar Brahma', 'Cervejaria do Gordo', 'Rey Castro', 'Excelenstíssimo',
               'Boteco Boa Praça', 'Bar Original', 'Pitico', 'Castro Burger', 'Pirajá']

place_addresses = ['Avenida Presidente Juscelino Kubitschek, 1444, São Paulo',
                   'Rua Girassol, 396, São Paulo',
                   'Rua Amauri, 284, São Paulo',
                   'Avenida Rebouças, 955, São Paulo',
                   'Rua Augusta, 3000, São Paulo',
                   'Rua Clodomiro Amazonas, 482, São Paulo',
                   'Rua Oscar Freire, 1128, São Paulo',
                   'Rua Cunha Gago, 864, São Paulo',
                   'Rua Harmonia, 77, São Paulo',
                   'Rua Aspicuelta, 567, São Paulo',
                   'Rua Conceição Veloso, 54, São Paulo',
                   'Rua Araújo, 124, São Paulo',
                   'Rua Antônio Lobo, 33, São Paulo',
                   'Rua Dr. José Paulo, 103',
                   'Rua Oscar Freire, 1052, São Paulo',
                   'Rua Fidalga, 531, São Paulo',
                   'Avenida Brigadeiro Faria Lima, 2902, São Paulo',
                   'Rua Gomes de Carvalho, 1705, São Paulo',
                   'Largo da Matriz de Nossa Senhora do Ó, 168, São Paulo',
                   'Rua Flórida, 1488 - Brooklin Novo, São Paulo',
                   'Praça Antônio Prado, 33 - Centro Histórico de São Paulo, São Paulo - SP, 05159-360',
                   'Avenida São João, 677, São Paulo',
                   'Rua Augusta, 1246, São Paulo',
                   'Rua Ministro Jesuíno Cardoso, 181, São Paulo',
                   'Rua Ramos Batista, 491, São Paulo',
                   'Avenida Brigadeiro Faria Lima, 3183, São Paulo',
                   'Rua Graúna, 137, São Paulo',
                   'Rua Guaicuí, 61, São Paulo',
                   'Rua Joaquim Távora, 1517, São Paulo',
                   'Avenida Brigadeiro Faria Lima, 64, São Paulo']

place_photos = ['https://lh5.googleusercontent.com/p/AF1QipPVj5EVhMNh1BggxUpyddSdbf0Dia0ET2AEioIE=w416-h240-k-no',
                'https://lh5.googleusercontent.com/p/AF1QipOiQzwA1kgkvwfF16PLxO2-5ZvBaRZPRPNoX0VE=w408-h306-k-no',
                'https://lh5.googleusercontent.com/p/AF1QipN0PWGMnIz1w0e2ZRC96N-KqU_j826dzp8qd_r_=w408-h271-k-no',
                'https://lh5.googleusercontent.com/p/AF1QipOBy75QhWxDN2OtD3q93hUvT0T6V5BBhFkOqrjM=w426-h240-k-no',
                'https://lh5.googleusercontent.com/p/AF1QipMoB9BlmQFCGID1a60ukY2B9-kKyX8oJtI2_yNB=w408-h272-k-no',
                'https://lh5.googleusercontent.com/p/AF1QipMN5K8mx4AO5ed4SKsX6vfJ2eT5WD6236CWAg4K=w408-h271-k-no',
                'https://lh5.googleusercontent.com/p/AF1QipOSyO8K9r2LN3NqJNkoxPTQJgcks9ht_RyJFuYy=w426-h240-k-no',
                'https://lh5.googleusercontent.com/p/AF1QipMSiMPYV6nvOlFK-oW5C7buAIMbIBlejtPuBco7=w408-h306-k-no',
                'https://lh5.googleusercontent.com/p/AF1QipPakvpypAQFJFXgj1zeGCuwCb2CIjRAqyYjaZj9=w408-h268-k-no',
                'https://lh5.googleusercontent.com/p/AF1QipOY7lNpk1BG02B0iGI1b0XfDqN8dtdP0E2VGWiN=w408-h271-k-no',
                'https://lh5.googleusercontent.com/p/AF1QipPd7N4Idhc2Isq85qN4nU7WH1q1n8CWXh7rotK1=w426-h240-k-no',
                'https://lh5.googleusercontent.com/p/AF1QipOvjBM7Sf9wz2tL6U1t9zz8kcewzf-69tzOoaAq=w408-h306-k-no',
                'https://lh5.googleusercontent.com/p/AF1QipOAfNJRlp_3nFebKg-FYNPgmjeXlkHzHtjtfq6f=w408-h544-k-no',
                'https://lh5.googleusercontent.com/p/AF1QipPfQ4K4lC6XOoy1VhxrsiBBp0VQOFZs_zfT8WMF=w426-h240-k-no',
                'https://lh5.googleusercontent.com/p/AF1QipM2RuI-DR5NZB4EWb96oKyZVunhlfSQus1BS8MX=w408-h240-k-no-pi-0-ya102.81043-ro-0-fo100',
                'https://lh5.googleusercontent.com/p/AF1QipPiYWTjQ-CQQKqOtJd83FMsB2qiwmxt1B0SbeVt=w408-h306-k-no',
                'https://lh5.googleusercontent.com/p/AF1QipPFXN0_t1_V4aRj5fTPwtceDxGDQ-SAYDAqnCCI=w408-h272-k-no',
                'https://lh5.googleusercontent.com/p/AF1QipMf1CQOQ8wywSvleq4JdP232-Iqd88zFNSh1YM1=w408-h272-k-no',
                'https://lh5.googleusercontent.com/p/AF1QipPFKrdrU_-5ipmbiQN5-AbVBOIOEJ8aDsSvmRHF=w408-h272-k-no',
                'https://lh5.googleusercontent.com/p/AF1QipMIiyaEcRkWDBeYQV954xSggZvYxZrfig3ZaEhG=w408-h612-k-no',
                'https://lh5.googleusercontent.com/p/AF1QipOATjS4HKkQxBk86jj6SSeEB2q7cp01G7zz9FtF=w458-h240-k-no',
                'https://lh5.googleusercontent.com/p/AF1QipOWlcyTd3Gc72xVI16khBV55OJyGKXxlh_P-ku9=w408-h282-k-no',
                'https://lh5.googleusercontent.com/p/AF1QipN9oBfVVIxf0uaFGIEJX0RcW3V3l26o0mxuy0ix=w408-h240-k-no-pi-10-ya189.45367-ro0-fo100',
                'https://lh5.googleusercontent.com/p/AF1QipOkLRgfzC2CmxVwgAaIaAV5xpQLTusX4qIt91fK=w408-h240-k-no-pi0-ya340.62485-ro-0-fo100',
                'https://lh5.googleusercontent.com/p/AF1QipPeoX_8yt686uGao316ja_Qy8OL38BFKkE5xfrp=w426-h240-k-no',
                'https://lh5.googleusercontent.com/p/AF1QipPIE9sNmDjGLeGFiP6KinWXo1YeiqpSYsB3_Cw8=w426-h240-k-no',
                'https://lh5.googleusercontent.com/p/AF1QipP_v23FZ3flW-N7pAnQ0tX79XiDGgD7Qo11CdE9=w408-h272-k-no',
                'https://lh5.googleusercontent.com/p/AF1QipPCiIV2sjKFBqlm2shZ0MRoBYCNemk5fdAy7s0b=w408-h544-k-no',
                'https://lh5.googleusercontent.com/p/AF1QipP0wQUc9qml-i78jnWIkfaaKskXxTTIL7ziwi08=w408-h560-k-no',
                'https://lh5.googleusercontent.com/p/AF1QipNzH0vU9ls0kd_EoCCRH3u83MRr5ZsoDen_wKLh=w408-h611-k-no']

place_descriptions = ['Almoço e happy hour estendido com DJs ,pista de dança e clima animado, em espaço de decoração moderna e retrô.',
                      'Com drinques sofisticados e gastronomia autoral, bar estilizado rústico tem snooker e fliperama em mezanino.',
                      'Em ambiente contemporâneo e descontraído, a casa oferece drinques clássicos e criativos, além de comidinhas.',
                      'Bar em cobertura de prédio, pratos, porções com toque gourmet, vinhos e drinques, destaque à vista da cidade.',
                      'Aperitivos generosos servidos com cerveja ou caipirinhas em um bar com fitas coloridas no teto.',
                      'Drinques criativos e comidinhas em casa noturna contemporânea com decoração artística, DJs e clima alegre.',
                      'Bar moderno com aperitivos gourmet, bebidas famosas, como cosmopolitan, em local elevado com vista.',
                      'Ambiente sofisticado e acolhedor com bebidas refinadas, alta gastronomia e carta de tapas.',
                      'Bar com aperitivos, um terraço pitoresco, mesas sob árvores frutíferas e música ao vivo nos fins de semana.',
                      'Drinques e petiscos de boteco, espaço com acústico sertanejo intimista, bate-papo e pista de dança animada.',
                      'Boteco animado e multipremiado, com clima carioca e várias opções de pratos, petiscos e caipirinhas famosas.',
                      'Bar casual conhecido pelo sanduíche de carne de porco assada com cebola roxa em conserva e guacamole.',
                      'Bom atendimento, ótima comida. Mesa na rua. Tem feijoada de sábado, mas tem que chegar cedo porque lota e acaba.',
                      'Bar casual tem clima intimista de confraria com seleção de cervejas e comidinhas de boteco com área externa.',
                      'Garrafas e chopp, varias sabores a descobrir e aproveitar tranquilamente na Galeria.',
                      'Bar espaçoso com três andares, petiscos e shows de rock animados. Aberto nas noites de quinta a sábado.',
                      'Bar rústico chique com ampla seleção de caipirinhas e música ao vivo.',
                      'Local com design moderno que oferece pacotes open bar e pista de dança e serve bebidas, risotos e massas.',
                      'Bar animado que conta com uma carta de cervejas bem diversificada e serve aperitivos, como asinhas de frango.',
                      'Local aconchegante com literatura, jazz, pratos internacionais e ênfase na culinária espanhola.',
                      'Um bar perfeito para socializar e que oferece um menu variado de entradas, petiscos e cervejas.',
                      'Um dos favoritos dos intelectuais, músicos e políticos nas décadas de 50 e 60, com cerveja, lanches e música.',
                      'Cervejaria contemporânea tem rusticidade e design, e serve hambúrgueres artesanais entre grelhados especiais.',
                      'Bar temático com shows de música caribenha e latina que serve diversos drinks e petiscos.',
                      'Bar animado, aberto até de madrugada, que serve bebidas e aperitivos selecionados.',
                      'Coquetelaria gastronômica de opções chamativas e variadas, em espaço convidativo repleto de temas inesperados.',
                      'Este bar local tem uma atmosfera festiva e serve diversos tipos de cachaça, sanduíches e petiscos brasileiros.',
                      'Bar e restaurante montado em contêineres com palco para shows e que serve comida libanesa e cerveja artesanal.',
                      'Hambúrgueres e outros sanduíches gourmets, além de sobremesas e bebidas, em casa acolhedora com área externa.',
                      'Conhecido como o cantinho carioca em São Paulo, este local tem chope, happy hour e um cardápio premiado.']

counter = 0
place_names.length.times do
  first_name = angel_first_names.sample
  last_name = user_last_names.sample
  username = "#{first_name.downcase}#{%w[. _ -].sample}#{last_name.downcase}"
  email = Faker::Internet.free_email(name: username)
  password = "123456"
  city = Faker::Address.city
  state = Faker::Address.state
  gender = %w[feminino masculino].sample.first
  phone_number = "#{rand(1..9)}#{rand(0..9)}9#{rand(2..9)}#{(0..9).to_a.sample(7).join}"
  cnpj = Faker::CNPJ.pretty
  longitude = rand(23.476482..23.637696).-@.round(6)
  latitude = rand(46.540127..46.732998).-@.round(6)
  business_user = User.create!(first_name: first_name,
                               last_name: last_name,
                               username: username,
                               email: email,
                               password: password,
                               city: city,
                               state: state,
                               is_business: true,
                               cnpj: cnpj,
                               gender: gender,
                               phone_number: phone_number,
                               longitude: longitude,
                               latitude: latitude)

  avatar_url = "https://api.adorable.io/avatars/285/#{business_user.id}ollivia.png"
  avatar = URI.open(avatar_url)
  business_user.photo.attach(io: avatar, filename: "#{business_user.username}.png", content_type: 'image/png')

  business_users << business_user

  puts "Business account #{business_user.username} created"

  venue = Place.create!(name: place_names[counter],
                        user: simple_users.sample,
                        owner: [business_user, business_user, nil].sample,
                        address: place_addresses[counter],
                        description: place_descriptions[counter])

  place_photo_url = place_photos[counter]
  place_photo = URI.open(place_photo_url)
  venue.photo.attach(io: place_photo, filename: "#{venue.name}.png", content_type: 'image/png')

  puts "#{venue.name} created"
  counter += 1
end

puts 'Creating bad reviews'
rand(20..25).times do
  title = Faker::Book.title
  content = Faker::Quote.famous_last_words
  rating = rand(0..3)
  good = false
  satisfied = false
  review = Review.create!(title: title,
                          content: content,
                          rating: rating,
                          user: simple_users.sample,
                          place: Place.all.sample,
                          is_good: good,
                          is_satisfied: satisfied)
  reviews = Review.where('place_id = ?', review.place.id)
  ratings = reviews.map(&:rating)
  review.place.update_attribute(:average_rating, ratings.sum / ratings.length.to_f)
  puts "#{review.place.name} reviewed by #{review.user.username}"
end

puts 'Creating good reviews'
rand(20..25).times do
  title = Faker::Book.title
  content = Faker::Movies::HitchhikersGuideToTheGalaxy.quote
  rating = rand(3..5)
  good = true
  satisfied = false
  review = Review.create!(title: title,
                          content: content,
                          rating: rating,
                          user: simple_users.sample,
                          place: Place.all.sample,
                          is_good: good,
                          is_satisfied: satisfied)
  reviews = Review.where('place_id = ?', review.place.id)
  ratings = reviews.map(&:rating)
  review.place.update_attribute(:average_rating, ratings.sum / ratings.length.to_f)
  puts "#{review.place.name} reviewed by #{review.user.username}"
end

puts 'Creating owners responses'
rand(10..20).times do
  response = Faker::Quote.famous_last_words
  review = Review.all.sample
  user = review.place.owner
  next if user.nil?

  Response.create!(response: response, user: user, review: review)
  review.update(is_satisfied: [false, true].sample)
  puts "#{review.place.owner.username} responded to a review"

  rand(0..1).times do
    user_response = Faker::Movies::HitchhikersGuideToTheGalaxy.quote
    Response.create!(response: user_response, user: review.user, review: review)
    puts "#{review.user.username} continued a thread."
  end
end

puts ""
puts "-----------------------------"
puts "Seed successfully created!!!!"
puts "-----------------------------"
