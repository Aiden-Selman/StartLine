require 'rest-client'

NUMBER_OF_GAMES = 2

AdminUser.delete_all
Game.delete_all
Platform.delete_all
Genre.delete_all

# Platform.create(platform_name: "Windows")
# Platform.create(platform_name: "Linux")
# Platform.create(platform_name: "Mac")
# Platform.create(platform_name: "Playstation")
# Platform.create(platform_name: "Xbox")
# Platform.create(platform_name: "Nintendo")

# Fetches the data from the API.
def fetch_data
  games_list = JSON.parse(File.read("db/steamgames.json"))

  # Iterates through the games list and prints out the data of the last NUMBER_OF_GAMES items.
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

    platform = Platform.find_or_create_by(platform_name: data[appid]["data"]["platforms"].map { |platform| platform[0] }.join(", "))
    genre = Genre.find_or_create_by(genre_name: data[appid]["data"]["genres"].map { |genre| genre["description"] }.join(", "))

    puts data[appid]['data']
    exit

    if platform && genre
      Game.create(
        game_name:          data[appid]["data"]["name"],
        # stean_appid:        appid.to_int,
        rating:             data[appid]["data"]["required_age"],
        description:        data[appid]["data"]["short_description"],
        price:              data[appid]&.dig("data", "price_overview", "final") || 0,
        platform_id:        platform.id,
        genre_id:           genre.id,
        release_date:       data[appid]["data"]["release_date"]["date"],
      )
    end
  end
end
fetch_data

AdminUser.create!(email: "admin@example.com", password: "password", password_confirmation: "password") if Rails.env.development?