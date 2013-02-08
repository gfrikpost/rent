namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = User.create!(:name => "Alex Horkov",
                         :email => "frikpost@mail.ru",
                         :password => "akjhblf88",
                         :password_confirmation => "akjhblf88")
    admin.toggle!(:admin)
    
    50.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end
    
    User.all(:limit => 6).each do |user|
      15.times do
        user.userposts.create!(:content => Faker::Lorem.sentence(100))
      end
    end
  end
end