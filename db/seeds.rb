AdminUser.delete_all
Game.delete_all
Platform.delete_all
Genre.delete_all

NUMBER_OF_GAMES = 100

Platform.create(platform_name: "PC")
Platform.create(platform_name: "Playstation")
Platform.create(platform_name: "Xbox")
Platform.create(platform_name: "Nintendo")



AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?