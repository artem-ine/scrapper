require_relative '../lib/mairie_christmas.rb'

require 'nokogiri'
require 'open-uri'


describe "#town_names" do
  it "returns an array of valid URLs for each town in the page" do
    towns = town_names()
    expect(towns.length).to be > 0

    towns.each do |town|
      expect(town).to match(/https:\/\/www\.annuaire-des-mairies\.com\/95\/[a-z-]+\.html/)
    end
  end
end

describe "#get_townhall_email" do
  it "returns an email address for a valid town URL" do
    email = get_townhall_email("https://www.annuaire-des-mairies.com/95/avernes.html")
    expect(email).to match(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i)
  end
end