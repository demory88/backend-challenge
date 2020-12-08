class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  require 'watir'

  has_and_belongs_to_many :users

  serialize :friends, Array

  def self.scrape_tags
  end

end
