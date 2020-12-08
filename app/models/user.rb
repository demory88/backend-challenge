class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  require 'watir'

  has_and_belongs_to_many :users

  serialize :friends, Array
  serialize :tags, Array

  def self.scrape_tags # make the user's tag list
    browser = Watir::Browser.new
    browser.goto(user.url)
    # go to their URL and find the headings
    h1_arr = browser.h1s
    h3_arr = browser.h3s

    h1_arr.each do |h1|
      user.tags << h1.text&.strip&.downcase
    end
    # scan them in and add them
    h3_arr.each do |h3|
      user.tags << h3.text&.strip&.downcase
    end

    pages = browser.links
    # find and go to the linked pages on their site
    pages.each do |page|
      if page.href.include?(user.url)
        browser.goto(page.href)
        # we really only want the links for their site, we don't accidentally want to scan their entire Facebook
        page_h1_arr.each do |h1|
          user.tags << h1.text&.strip&.downcase
        end
        # same as above - scan and add
        page_h3_arr.each do |h3|
          user.tags << h3.text&.strip&.downcase
        end
      end
    end

    end

    user.save
  end

end
