namespace :hexlet do
  desc 'Import users from users.csv'
  task :import_users, [:file] => :environment do |t, args|
    #require 'csv'
    file = args[:file]
    puts 'Import users...'
    first_line = true
    CSV.foreach(file) do |row|
      if first_line; first_line = false; next; end
      (first_name, last_name, birthday, email) = row
      birthday = Date.strptime(birthday, '%m/%d/%Y')
      User.create(first_name: first_name, last_name: last_name, birthday: birthday, email: email)
      print '.'
    end
    puts
    puts 'Done!!!'
  end
end
