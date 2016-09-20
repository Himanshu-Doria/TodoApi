class User < ActiveRecord::Base
    include Tire::Model::Search
    include Tire::Model::Callbacks

    
    has_many :todos, dependent: :destroy
    has_secure_password
    AGE_REGEX = /\d/i
    attr_accessor :remember_token
    before_save {self.email = email.downcase}
    before_create :generate_token_for_auth
    validates :email, presence: true, uniqueness: {case_sensitive: false}
    validates :password, length: {minimum: 6}, on: :create
    validates :password, length: {minimum: 6}, allow_blank: true, on: :update
    validates :age,format: {:with => AGE_REGEX},allow_blank: true,length: {maximum: 2},on: :update

    def self.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create(string,cost: cost)
    end

    def self.new_token
        SecureRandom.urlsafe_base64
    end

    def auth_token_expired?
        2 == 4
    end

    def generate_time_stamp
        self.expires_on = 20.days.from_now.to_date
    end
    def generate_auth_token
        begin
            self.remember_token = self.class.new_token
            self.remember_digest = self.class.digest(remember_token)
        end while self.class.exists?(remember_digest: remember_digest)
    end

    def generate_token_for_auth
        begin
            self.remember_token = self.class.new_token
            self.remember_digest = self.class.digest(remember_token)
        end while self.class.exists?(remember_digest: remember_digest)
        generate_time_stamp
    end
end
