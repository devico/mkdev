name_film = ARGV[0]
film_bad = "Titanic"
film_good = "Matrix"

if name_film == film_bad
  puts "#{film_bad} is a bad movie"
elsif name_film == film_good
  puts "#{film_good} is a good movie"
else 
  puts "Haven\'t seen #{name_film} yet"
end