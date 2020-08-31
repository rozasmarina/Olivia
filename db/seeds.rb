require 'open-uri'
puts "Destroying DB..."

# Review.destroy_all
# Place.destroy_all
# # Angels.destroy_all
# User.destroy_all

simple_users = []
business_users = []

puts "Creating personal users...And angels"
sleep(1)

10.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  username = Faker::Internet.username(specifier: "#{first_name} #{last_name}", separators: %w[. _ -])
  email = Faker::Internet.free_email(name: username)
  password = "123456"
  city = Faker::Address.city
  state = Faker::Address.state
  gender = %w[feminino feminino feminino outro masculino].sample
  phone_number = "#{rand(1..9)}#{rand(0..9)}9#{rand(2..9)}#{(0..9).to_a.sample(7).join}"
  cpf = rand.to_s[2..12]
  latitude = "23#{rand(4..6)}#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}"
  longitude = "46#{rand(5..8)}#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}"
  simple_user = User.create!(first_name: first_name,
                            last_name: last_name,
                            username: username,
                            email: email,
                            password: password,
                            city: city,
                            state: state,
                            business: false,
                            cpf: cpf,
                            latitude: latitude,
                            longitude: longitude,
                            gender: gender,
                            phone_number: phone_number)
  simple_users << simple_user

  # avatar_url = "https://api.adorable.io/avatars/285/#{simple_user.id}handmazing.png"
  # avatar = URI.open(avatar_url)
  # simple_user.photo.attach(io: avatar, filename: "#{simple_user.username}.png", content_type: 'image/png')
  puts "#{simple_user.username} created"

  rand(1..3).times do
    email = Faker::Internet.free_email(name: username)
    phone_number = "#{rand(1..9)}#{rand(0..9)}9#{rand(2..9)}#{(0..9).to_a.sample(7).join}"
    first_name = Faker::Name.first_name
    Angel.create!(first_name: first_name,
                  email: email,
                  phone_number: phone_number,
                  user: simple_users.sample)
  end
end

puts "Creating reviewed places..."
sleep(1)

10.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  username = Faker::Internet.username(specifier: "#{first_name} #{last_name}", separators: %w[. _ -])
  email = Faker::Internet.free_email(name: username)
  password = "123456"
  city = Faker::Address.city
  state = Faker::Address.state
  gender = %w[feminino masculino].sample
  phone_number = "#{rand(1..9)}#{rand(0..9)}9#{rand(2..9)}#{(0..9).to_a.sample(7).join}"
  cnpj = rand.to_s[2..14]
  latitude = "23#{rand(4..6)}#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}"
  longitude = "46#{rand(5..8)}#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}"
  business_user = User.create!(first_name: first_name,
                              last_name: last_name,
                              username: username,
                              email: email,
                              password: password,
                              city: city,
                              state: state,
                              business: true,
                              cnpj: cnpj,
                              latitude: latitude,
                              longitude: longitude,
                              gender: gender,
                              phone_number: phone_number)
  business_users << business_user

  # avatar_url = "https://api.adorable.io/avatars/285/#{business_user.id}handmazing.png"
  # avatar = URI.open(avatar_url)
  # business_user.photo.attach(io: avatar, filename: "#{business_user.username}.png", content_type: 'image/png')
  puts "Business account #{business_user.username} created"

  rand(2..3).times do
    latitude = "23#{rand(4..6)}#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}"
    longitude = "46#{rand(5..8)}#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}"
    name = Faker::Restaurant.name  
    venue = Place.create!(name: name,
                        latitude: latitude,
                        longitude: longitude,
                        user: simple_users.sample,
                        owner: business_users.sample)
    puts "#{venue.name} created"
  end


rand(4..10).times do
   content = Faker::Lorem.paragraphs.join.to_s
   rating = "#{rand(1..5)} stars"
   review = Review.create!(content: content,
                          rating: rating,
                          user: simple_users.sample,
                          place: Place.all.sample)
  puts "#{review.place.name} reviewed by #{review.user.username}"
  end

  rand(4..10).times do
    content = Faker::Lorem.paragraphs.join.to_s
    response = Faker::Lorem.paragraphs.join.to_s
    rating = "#{rand(1..5)} stars"
    review = Review.create!(content: content,
                           rating: rating,
                           user: simple_users.sample,
                           place: Place.all.sample,
                           response: response)
  puts "#{review.place.name} reviewed by #{review.user.username}; venue responded"
   end
end

puts "Seed successfully created!!!!"