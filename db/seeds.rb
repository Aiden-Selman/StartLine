require 'rest-client'

AdminUser.delete_all
Game.delete_all
Platform.delete_all
Genre.delete_all

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

    # Gets the price of the game. If the price is nil, it will be set to zero.
    price = data.dig(appid, "data", "price_overview", "final").to_i

    # Skips the rest of the loop if the price is zero.
    next if price.zero?

    puts "----------------------------------------"
    puts "Steam App ID: #{appid}"

    game_name = data&.dig(appid, "data", "name")
    puts "Game Name: #{game_name || 'N/A'}"

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
    Game.create(game_name:, rating:, description:, price:, platform_id:, genre_id:, release_date:, )

    # Exits the loop if the number of fetched games is equal to the NUMBER_OF_GAMES
    fetched_games += 1
    puts "Fetched Games: #{fetched_games}"
    break if fetched_games >= NUMBER_OF_GAMES
  end
end

AdminUser.create!(email: "admin@example.com", password: "password", password_confirmation: "password") if Rails.env.development?
fetch_data