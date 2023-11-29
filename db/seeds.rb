require 'rest-client'

NUMBER_OF_GAMES = 2

AdminUser.delete_all
Game.delete_all
Platform.delete_all
Genre.delete_all

# Platform.create(platform_name: "PC")
# Platform.create(platform_name: "Playstation")
# Platform.create(platform_name: "Xbox")
# Platform.create(platform_name: "Nintendo")

# Fetches the data from the API.
def fetch_data
  games_list = JSON.parse(File.read("db/steamgames.json"))

  games_list["applist"]["apps"].last(NUMBER_OF_GAMES).each do |game|
    appid = game["appid"].to_s
    fetch = RestClient.get("https://store.steampowered.com/api/appdetails?appids=#{appid}")
    data = JSON.parse(fetch)

    puts "Game Name: #{data[appid]['data']['name']}"
    puts "Steam App ID: #{data[appid]['data']['steam_appid']}"
    puts "Required Age: #{data[appid]['data']['required_age']}"
    puts "Short Description: #{data[appid]['data']['short_description']}"
    puts "Price: #{data[appid]&.dig('data', 'price_overview', 'initial') || 0}"
    puts "Platforms: #{data[appid]['data']['platforms'].map { |platform| platform[0] }.join(', ')}"
    puts "Genres: #{data[appid]['data']['genres'].map { |genre| genre['description'] }.join(', ')}"
    puts "Release Date: #{data[appid]['data']['release_date']['date']}"
    puts "----------------------------------------"
  end
end
fetch_data

# NUMBER_OF_GAMES.times do |i|
#   # Step 1: Get game info from API call.
#   # Step 2: Check that games genre. If it doesn't exist in the database, add it, if it does, skip it.
#   # Step 3: Create the game with the correct data and connections to other tables (platform and genre).
#   game_info = URI.open("https://store.steampowered.com/api/appdetails?appids=#{i + 10}")
#   break
#   # puts game_id, game_info
#   # genre = Genre.create(genre_name: )
# end

AdminUser.create!(email: "admin@example.com", password: "password", password_confirmation: "password") if Rails.env.development?