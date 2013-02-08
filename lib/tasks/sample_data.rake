namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
<<<<<<< HEAD
    admin = User.create!(:name => "Alex Horkov",
=======
    admin = User.create!(:name => "Admin",
>>>>>>> f85b9bf0dff67633dafc8d04eff5b2ccd4aeca3f
                         :email => "frikpost@mail.ru",
                         :password => "akjhblf88",
                         :password_confirmation => "akjhblf88")
    admin.toggle!(:admin)
    
<<<<<<< HEAD
    50.times do |n|
=======
    15.times do |n|
>>>>>>> f85b9bf0dff67633dafc8d04eff5b2ccd4aeca3f
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