namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_exercises
    make_relationships
    make_bands
    make_pullup_types
    make_bands_used
  end
end

def make_users
	admin = User.create!(name: "Example User",
		           email: "jmcmains@gmail.com",
		           password: "foobar",
		           password_confirmation: "foobar")
	admin.toggle!(:admin)
	99.times do |n|
		name  = Faker::Name.name
		email = "example-#{n+1}@railstutorial.org"
		password  = "password"
		User.create!(name: name,
		             email: email,
		             password: password,
		             password_confirmation: password)
	end
end
   
def make_bands
	list=["None","Light","Medium","Heavy","Robust","Power","Strong","Monster"]
	list.each do |b|
		Band.create!(name: b)
	end
end

def make_pullup_types
	list=["Wide grip pull up","Narrow grip pull up","Normal grip pull up","Wide grip chin up","Narrow grip chin up","Normal grip chin up"]
	list.each do |b|
		PullupType.create!(name: b)
	end
end
 
def make_exercises
	users = User.all(limit: 6)
	50.times do
		content = Faker::Lorem.sentence(5)
		pullup_type=rand(5)+1
		reps = rand(20)+1
		date =rand(50).days.ago;
		users.each { |user| user.exercises.create!(content: content, pullup_type_id: pullup_type, reps: reps, date: date) }
	end
end

def make_bands_used
	exercises = Exercise.all
	exercises.each do |ex|
		ex.bands_used.create!(band_id: rand(6)+1)
	end
end

def make_relationships
	users = User.all
	user = users.first
	followed_users = users[2..50]
	followers = users[3..40]
	followed_users.each { |followed| user.follow!(followed) }
	followers.each { |follower| follower.follow!(user) }
end

