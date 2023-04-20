require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'watir' # to load additional values if needed


# get all the town names
def town_names
  begin
    page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/val-d-oise.html"))
  rescue => e
    puts "Error loading page: #{e.message}"
    exit
  end

  towns = page.xpath("//a[@class='lientxt']/text()")
  if towns.empty?
    p "No town found"
    exit
  end

  town_urls = towns.map { |town| "https://www.annuaire-des-mairies.com/95/#{town.text.downcase.gsub(" ", "-")}.html" }
  return town_urls # array of town names in lowercase, with spaces replaced by -, and with html at the end
end


#getting the email of one town hall
def get_townhall_email(town_hall_url)
  begin
    page = Nokogiri::HTML(URI.open(town_hall_url))
  rescue => e
    puts "Error loading page: #{e.message}"
    exit
  end

  town_hall_email = page.xpath('//section[2]//tr[4]//td[2]')
  if town_hall_email.empty?
    p "No email found"
    exit
  end
  town_hall_email.each do |email|
    p email.text
  end
end


def get_all_townhall_emails
  town_urls = town_names
  town_urls.each do |town_url|
    get_townhall_email(town_url)
  end
end

get_all_townhall_emails