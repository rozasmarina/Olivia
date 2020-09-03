class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :angels
  has_many :places, class_name: "Place", foreign_key: "owner_id"
  has_many :reviews
  has_many :responses
  has_one_attached :photo

  validates :first_name, :last_name, :phone_number, :username, :email, :city, :state, :gender,
            presence: { message: "Campo obrigatório" }
  validates :is_business, inclusion: { in: [true, false] }
  validates :username, :email, uniqueness: true
  validates :email, confirmation: true
  validates :cpf, uniqueness: { if: -> { cpf.present? } }
  validates :cnpj, uniqueness: { if: -> { cnpj.present? } }

  validates :cpf, presence: { if: -> { cnpj.blank? } }
  validates :cnpj, presence: { if: -> { cpf.blank? } }

  validates :first_name, :last_name,
            format: { with: /[A-Za-z]+/,
                      message: "Utilize somente letras" }

  validates :username,
            format: { with: /\A(?=[a-zA-Z0-9._-]{5,20}$)(?!.*[_.]{2})[^_.].*[^_.]\z/,
                      message: "Deve ter entre 5 e 20 caracateres" }

  validates :phone_number,
            format: { with: /\A(?:(?:\+|00)?(55)\s?)?(?:\(?([1-9][0-9])\)?\s?)?(?:((?:9\d|[2-9])\d{3})-?(\d{4}))\z/,
                      message: "Entre um telefone válido" }

  validates :cpf,
            format: { if: -> { cnpj.blank? },
                      with: /\A\d{3}\.?\d{3}\.?\d{3}-?\d{2}\z/,
                      message: "Entre um CPF válido" }

  validates :cnpj,
            format: { if: -> { cpf.blank? },
                      with: %r{\A\d{2}\.?\d{3}\.?\d{3}/\d{4}-?\d{2}\z},
                      message: "Entre um CNPJ válido" }

  def set_default_avatar
    unless photo.attached?
      avatar_url = "https://api.adorable.io/avatars/285/#{id}ollivia.png"
      avatar = URI.open(avatar_url)
      photo.attach(io: avatar, filename: "#{username}.png", content_type: 'image/png')
    end
  end
end
