file_name = ARGV[0] || "movies.txt"

if File.exist?(file_name)
  file = File.open(file_name)
else
  puts "Ошибка. Файл отсутствует!"
  exit
end

FIELDS_ORDER = [:link, :title, :year, :country, :date, :genre, :length, :rate, :author, :actors]
films = file.map { |line| FIELDS_ORDER.zip(line.split('|')).to_h }

#выводим 5 самых длинных фильмов
def show(f)
  puts "#{ f[:title]} (#{f[:date]} #{f[:genre]}) - #{f[:length] }"
end

films
  .sort_by { |f| -f[:length].to_i }
  .take(5)
  .each { |a| show(a) }

#10 комедий (первые по дате выхода)
films
  .select { |f| f[:genre].match(/Comedy/)}
  .sort_by { |c| c[:year] }
  .take(10)
  .each { |a| puts "#{a[:title]} - #{a[:genre]} - #{a[:year]}"}

# список всех режиссёров по алфавиту

films
  .sort_by { |f| f[:author].split(' ').reverse.join(" ") }
  .uniq{ |f| f[:author] }
  .each { |a| puts a[:author]}

# количество фильмов, снятых не в США
puts films.each.count { |f| f[:country] != "USA" }

