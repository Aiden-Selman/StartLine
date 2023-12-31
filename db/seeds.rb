require 'rest-client'

AdminUser.delete_all
Game.delete_all
Platform.delete_all
Genre.delete_all
About.delete_all
Contact.delete_all
Province.delete_all

NUMBER_OF_GAMES = 100
GAMES_LIST = JSON.parse(File.read("db/steamgames.json"))

# Fetches the data from the API.
def fetch_data
  fetched_games = 0

  GAMES_LIST["applist"]["apps"].each do |game|
    appid = game["appid"].to_s
    # Skips the rest of the loop if the appid is nil or empty.
    next if appid.nil? || appid.empty?

    # Fetches the data from the API.
    fetch = RestClient.get("https://store.steampowered.com/api/appdetails?appids=#{appid}")
    data = JSON.parse(fetch)
    sleep(1)

    # Check if data returned successfully if not, skip
    next if data.dig(appid, "success") == false

    # Gets the price of the game. If the price is nil, it will be set to zero.
    price = data.dig(appid, "data", "price_overview", "final").to_i

    # Skips the rest of the loop if the price is zero.
    next if price.zero?

    puts "----------------------------------------"
    puts "Steam App ID: #{appid}"

    game_name = data&.dig(appid, "data", "name")
    puts "Game Name: #{game_name || 'N/A'}"

    puts "Backgroud URL: #{data.dig(appid, "data", "background")}"

    required_age = data&.dig(appid, "data", "required_age")
    puts "Required Age: #{required_age || 'N/A'}"

    rating = case required_age
      when 0..9
        "E for everyone"
      when 10..12
        "E for everyone 10 and up"
      when 13..16
        "T for Teen"
      when 17
        "M for Mature"
      when 18..150
        "AO for Adults Only"
      else
        "RP for Rating Pending"
    end
    puts "Rating: #{rating || 'N/A'}"

    description = data&.dig(appid, "data", "short_description")
    puts "Short Description: #{description || 'N/A'}"

    # TODO: Break into individual platform
    platform_names = data&.dig(appid, "data", "platforms")&.map { |platform| platform[0] }&.join(", ")
    puts "Platforms: #{platform_names || 'N/A'}"

    # TODO: Break into individual genre
    genre_names = data&.dig(appid, "data", "genres")&.map { |genre| genre["description"] }&.join(", ")
    puts "Genres: #{genre_names || 'N/A'}"

    release_date = data&.dig(appid, "data", "release_date", "date")
    puts "Release Date: #{release_date || 'N/A'}"
    puts "----------------------------------------"

    # Seeds the database.
    platform_id = Platform.find_or_create_by(platform_name: platform_names).id
    genre_id = Genre.find_or_create_by(genre_name: genre_names).id
    background_image_download = URI.open(data.dig(appid, "data", "background"))
    game = Game.create(game_name:, rating:, description:, price:, platform_id:, genre_id:, release_date:, )
    game.image.attach(io: background_image_download, filename: "m-#{game.game_name}-background.jpg")

    # Exits the loop if the number of fetched games is equal to the NUMBER_OF_GAMES
    fetched_games += 1
    puts "Fetched Games: #{fetched_games}"
    break if fetched_games >= NUMBER_OF_GAMES
  end
end

Province.create(province_name: "Alberta", pst: 0, gst: 0.05, hst: 0)
Province.create(province_name: "British Columbia", pst: 0.07, gst: 0.05, hst: 0)
Province.create(province_name: "Manitoba", pst: 0.07, gst: 0.05, hst: 0)
Province.create(province_name: "New Brunswick", pst: 0, gst: 0, hst: 0.15)
Province.create(province_name: "Newfoundland and Labrador", pst: 0, gst: 0, hst: 0.15)
Province.create(province_name: "Northwest Territories", pst: 0, gst: 0.05, hst: 0)
Province.create(province_name: "Nova Scotia", pst: 0, gst: 0, hst: 0.15)
Province.create(province_name: "Nunavut", pst: 0, gst: 0.05, hst: 0)
Province.create(province_name: "Ontario", pst: 0, gst: 0, hst: 0.13)
Province.create(province_name: "Prince Edward Island", pst: 0, gst: 0, hst: 0.15)
Province.create(province_name: "Quebec", pst: 0.09975, gst: 0.05, hst: 0)
Province.create(province_name: "Saskatchewan", pst: 0.06, gst: 0.05, hst: 0)
Province.create(province_name: "Yukon", pst: 0, gst: 0.05, hst: 0)
AdminUser.create!(email: "admin@example.com", password: "password", password_confirmation: "password") if Rails.env.development?
About.create(content: "Here is a little bit about us!")
Contact.create(content: "Here is how you can reach us!")
fetch_data