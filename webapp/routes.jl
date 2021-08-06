using Genie.Router
using Genie.Renderer.Html
using CSV

struct Value
  total::Float64
  offensive::Float64
  defensive::Float64
end

struct Player
    name::String
    minutes_played::Int
    value_per_minute::Value
end

players = [
  Player(player.player_name, player.minutes_played, 
         Value(
           player.vaep_rating,
           player.offensive_rating,
           player.defensive_rating))
  for player in CSV.File("data/player_stats.csv")
]

route("/") do
  serve_static_file("welcome.html")
end

route("/players") do
  html(:players, :index, players=players)
end
