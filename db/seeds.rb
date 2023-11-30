require 'rest-client'

NUMBER_OF_GAMES = 10

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
  fetched_games = 0

  games_list["applist"]["apps"].each do |game|
    appid = game["appid"].to_s
    fetch = RestClient.get("https://store.steampowered.com/api/appdetails?appids=#{appid}")
    data = JSON.parse(fetch)

    # Gets the price of the game. If the price is nil, it will be set to 0.
    price = data.dig(appid, "data", "price_overview", "final") || 0

    # Skips the rest of the loop if the price is 0.
    next if price.zero?

    rating = ""
    if data[appid]['data']['reqired_age'] < 10
      rating = "E for everyone"
    elsif data[appid]['data']['reqired_age'] >= 10 && data[appid]['data']['reqired_age'] < 13
      rating = "E for everyone 10 and up"
    elsif data[appid]['data']['reqired_age'] >= 13 && data[appid]['data']['reqired_age'] < 17
      rating = "T for Teen"
    elsif data[appid]['data']['reqired_age'] >= 17 && data[appid]['data']['reqired_age'] < 18
      rating = "M for Mature"
    elsif data[appid]['data']['reqired_age'] >= 18
      rating = "AO for Adults Only"
    else
      rating = "RP for Rating Pending"
    end

    puts "Game Name: #{data[appid]['data']['name']}"
    puts "Steam App ID: #{data[appid]['data']['steam_appid']}"
    puts "Required Age: #{data[appid]['data']['required_age']}"
    puts "Short Description: #{data[appid]['data']['short_description']}"
    # puts "Price: #{data[appid]&.dig('data', 'price_overview', 'final') || 0}"
    puts "Price: #{price}"
    puts "Platforms: #{data[appid]['data']['platforms']&.map { |platform| platform[0] }&.join(', ') || ""}"
    puts "Genres: #{data[appid]['data']['genres']&.map { |genre| genre['description'] }&.join(', ') || ""}"
    puts "Release Date: #{data[appid]['data']['release_date']['date']}"
    puts "----------------------------------------"

    platform = Platform.find_or_create_by(platform_name: data[appid]["data"]["platforms"]&.map { |platform| platform[0] }&.join(", ") || "")
    genre = Genre.find_or_create_by(genre_name: data[appid]["data"]["genres"]&.map { |genre| genre["description"] }&.join(", ") || "")



    if platform && genre
      Game.create(
        game_name:          data[appid]["data"]["name"],
        # stean_appid:        appid.to_int,
        rating:             rating,
        description:        data[appid]["data"]["short_description"],
        price:              data[appid]&.dig("data", "price_overview", "final") || 0,
        platform_id:        platform.id,
        genre_id:           genre.id,
        release_date:       data[appid]["data"]["release_date"]["date"],
      )
    end

    # Exits the loop if the number of fetched games is equal to the NUMBER_OF_GAMES
    fetched_games += 1
    puts "Fetched Games: #{fetched_games}"
    puts "----------------------------------------"
    break if fetched_games >= NUMBER_OF_GAMES
  end
end
fetch_data

AdminUser.create!(email: "admin@example.com", password: "password", password_confirmation: "password") if Rails.env.development?