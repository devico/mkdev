name_film = ARGV.first
films = ["Titanic", "Matrix", "Revolver", "Equalizer"]

if films.include?(name_film)
  puts "#{name_film} is a good movie"
else 
  puts "#{name_film} is a bad movie"
end
