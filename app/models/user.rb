class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  require 'watir'

  has_and_belongs_to_many :users

  serialize :friends, Array
  serialize :tags, Array

  def self.scrape_tags user # make the user's tag list
    browser = Watir::Browser.new
    begin
      browser.goto(user.url)
      # go to their URL and find the headings
      # scan them in and add them
      browser.h1s.each do |h1|
        user.tags << h1.text&.strip&.downcase
      end
      browser.h2s.each do |h2|
        user.tags << h2.text&.strip&.downcase
      end
      browser.h3s.each do |h3|
        user.tags << h3.text&.strip&.downcase
      end

      pages = browser.links
      # find and go to the linked pages on their site

      pages.each do |page|
        if page.href.include?(user.url)
          # we really only want the links for their site, we don't accidentally want to scan their entire Facebook
          browser.goto(page.href)
          # same as above - scan and add
          browser.h1s.each do |h1|
            user.tags << h1.text&.strip&.downcase
          end
          browser.h2s.each do |h2|
            user.tags << h2.text&.strip&.downcase
          end
          browser.h3s.each do |h3|
            user.tags << h3.text&.strip&.downcase
          end
        end
      end
    rescue Watir::Exception::UnknownObjectException, Timeout::Error
      # We're going to use a catchall to rescue and save what we got here because watir can be very error prone, especially when dealing with SPAs
      user.tags = user.tags.uniq
      user.tags = user.tags.reject { |t| t.to_s.empty? }
      # cleanup and save
      user.save
    end

    user.tags = user.tags.uniq
    user.tags = user.tags.reject { |t| t.to_s.empty? }
    # cleanup and save
    user.save
  end

end
