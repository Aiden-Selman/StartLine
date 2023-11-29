AdminUser.delete_all
Game.delete_all
Platform.delete_all
Genre.delete_all

NUMBER_OF_GAMES = 100

Platform.create(platform_name: "PC")
Platform.create(platform_name: "Playstation")
Platform.create(platform_name: "Xbox")
Platform.create(platform_name: "Nintendo")

NUMBER_OF_GAMES.times do |i|
  # Step 1: Get game info from API call.
  # Step 2: Check that games genre. If it doesn't exist in the database, add it, if it does, skip it.
  # Step 3: Create the game with the correct data and connections to other tables (platform and genre).
  game_info = URI.open("https://store.steampowered.com/api/appdetails?appids=#{i + 1}")
  break
  # puts game_id, game_info
  # genre = Genre.create(genre_name: )
end



AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?