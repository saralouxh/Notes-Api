class User < ApplicationRecord
    has_secure_password validations: true
    validates :email, uniqueness: true
    has_many :tokens
    has_many :notes

    def generate_token!(ip)
        token = Token.create(
            value: SecureRandom.hex,
            user_id: id,
            expiry: DateTime.current + 7.days,
            ip: ip
        )
    end
end
