if ARGV.length !=1 then
  file_name = "movies.txt"
else
  file_name = ARGV[0]
end

begin
  file = File.open(file_name)
rescue
  puts "Ошибка. Файл отсутствует!"
  exit
end

file.each do |line|
  lines = line.split('|')
  # проверяем поле название на наличие Time
  if lines[1].match(/Time\s/)
  	# подсчитываем нужное число * из дробной части рейтинга
  	x, y = lines[7].to_s.split('.')
  	y = y.to_i
  	puts "#{lines[1]} #{"*" * y}"
  end
end