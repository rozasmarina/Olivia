class Angel < ApplicationRecord
  belongs_to :user

  validates :first_name, :last_name, :email, :phone_number, presence: true

  validates :first_name, :last_name,
            format: { with: /[A-Za-z]+/,
                      message: "Utilize somente letras" }

  validates :phone_number,
            format: { with: /\A(?:(?:\+|00)?(55)\s?)?(?:\(?([1-9][0-9])\)?\s?)?(?:((?:9\d|[2-9])\d{3})-?(\d{4}))\z/,
                      message: "Entre um telefone válido" }

  validates :email,
            format: { with: /\A(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})\z/,
                      message: "Entre um e-mail válido" }
end
