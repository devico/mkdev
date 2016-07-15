 require 'ostruct'
 require 'csv'
 require 'date'

file_name = ARGV[0] || "movies.txt"

if File.exist?(file_name)
  file = File.open(file_name)
else
  puts "Ошибка. Файл отсутствует!"
  exit
end

films = CSV.read(file, col_sep: '|', headers: %i[ link title year country date genre length rate author actors ] ).map { |film| OpenStruct.new film.to_h }

#выводим 5 самых длинных фильмов
def show(f)
  puts "#{ f.title} (#{f.date} #{f.genre}) - #{f.length }"
end

films
  .sort_by { |f| -f.length.to_i }
  .take(5)
  .each { |a| show(a) }

#10 комедий (первые по дате выхода)
films
  .reject { |c| !c.genre.split(",").include?("Comedy")}
  .sort_by(&:year)
  .take(10)
  .each { |a| puts "#{a.title} - #{a.genre} - #{a.year}"}

# список всех режиссёров по алфавиту
films
  .sort_by { |a| a.author.split(' ').reverse.join(" ") }
  .uniq(&:author)
  .each { |a| puts a.author}

# количество фильмов, снятых не в США
puts films.each.count { |f| f.country != "USA" }

groups = films.reject{ |f|
  !f.date.include?('-') }
  .group_by{ |f|
    Date.strptime( f.date, '%Y-%m').mon
  }.sort

groups.map { |month, group| puts "#{ Date.strptime(month.to_s, '%m').strftime('%B') } - #{group.count}" }
