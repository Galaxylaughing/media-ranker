# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

MEDIA_FILE = Rails.root.join('db', 'media-seeds.csv')
puts "Loading raw media data from #{MEDIA_FILE}"

media_failures = []
CSV.foreach(MEDIA_FILE, :headers => true) do |row|
  work = Work.new
  work.category = row['category']
  work.name = row['title']
  work.creator = row['creator']
  work.published_date = (row['publication_year'] + "-01-01")
  work.description = row['description']
  
  successful = work.save
  if !successful
    media_failures << work
    puts "Failed to save media: #{work.inspect}"
  else
    puts "Created media: #{work.inspect}"
  end
end

puts "Added #{Work.count} media records"
puts "#{media_failures.length} works failed to save"


works_data = [
  {
    category: "book",
    name: "The Name of the Wind",
    creator: "Patrick Rothfuss",
    description: "A good fantasy book",
    published_date: "January 1 2007"
  },
  {
    category: "book",
    name: "Spinning Silver",
    creator: "Naomi Novik",
    description: "A Russian-inspired fantasy",
    published_date: "January 1 2018"
  },
  {
    category: "book",
    name: "All Systems Red",
    creator: "Martha Wells",
    description: "A good sci-fi novella",
    published_date: "January 1 2017"
  },
  {
    category: "book",
    name: "Artificial Condition",
    creator: "Martha Wells",
    description: "A good sci-fi novella",
    published_date: "January 1 2018"
  },
  {
    category: "book",
    name: "Uglies",
    creator: "Scott Westerfeld",
    description: "A good sci-fi YA book",
    published_date: "January 1 2005"
  },
  {
    category: "book",
    name: "Darius the Great Is Not Okay",
    creator: "Adib Khorram",
    description: "A comedic contemporary YA book about the son of Iranian immigrants reconnecting with his parent's homeland on a family trip",
    published_date: "January 1 2018"
  },
  {
    category: "book",
    name: "Life After Life",
    creator: "Jill McCorkle",
    description: "A witty book set at Pine Haven retirement center",
    published_date: "January 1 2013"
  },
  {
    category: "book",
    name: "Life After Life",
    creator: "Kate Atkinson",
    description: "A dark comedy about a woman who keeps dying over and over again",
    published_date: "January 1 2013"
  },
  {
    category: "book",
    name: "Truly Devious",
    creator: "Maureen Johnson",
    description: "A YA mystery",
    published_date: "January 1 2018"
  },
  {
    category: "book",
    name: "Indigo Girl",
    creator: "Natasha Boyd",
    description: "A historical fiction novel",
    published_date: "January 1 2017"
  },
  {
    category: "book",
    name: "Illuminae",
    creator: "Amie Kaufman",
    description: "A great science fiction story",
    published_date: "January 1 2016"
  },
  {
    category: "movie",
    name: "The Hunt for Red October",
    creator: "John McTiernan",
    description: "Cold War spy thriller with submarines",
    published_date: "January 1 1990"
  },
  {
    category: "movie",
    name: "The Women's Balcony",
    creator: "Emil Ben-Shimon",
    description: "Israeli comedy film",
    published_date: "January 1 2016"
  },
  {
    category: "movie",
    name: "Your Name",
    creator: "Makoto Shinkai",
    description: "Animated Japanese film. You should see it. No spoilers. Just trust me",
    published_date: "January 1 2017"
  },
  {
    category: "movie",
    name: "Castle in the Sky",
    creator: "Hayao Miyazaki",
    description: "Animated sci-fi movie",
    published_date: "January 1 1986"
  },
  {
    category: "movie",
    name: "Spirited Away",
    creator: "Hayao Miyazaki",
    description: "Animated fantasy (urban fantasy?) movie",
    published_date: "January 1 2001"
  },
  {
    category: "movie",
    name: "A New Hope",
    creator: "George Lucas",
    description: "star warssss. the one with the double-sun shot.",
    published_date: "January 1 1977"
  },
  {
    category: "movie",
    name: "The Empire Strikes Back",
    creator: "George Lucas",
    description: "star warssss. the one with the ice planet",
    published_date: "January 1 1980"
  },
  {
    category: "movie",
    name: "Return of the Jedi",
    creator: "George Lucas",
    description: "star warssss. the one with the ewoks",
    published_date: "January 1 1983"
  },
  {
    category: "movie",
    name: "Chitty Chitty Bang Bang",
    creator: "Ken Hughes",
    description: "A fantasy musical. A wild ride",
    published_date: "January 1 1986"
  },
  {
    category: "movie",
    name: "Monsters, Inc.",
    creator: "Pete Doctor",
    description: "A classic",
    published_date: "January 1 2001"
  },
  {
    category: "album",
    name: "The Noteworthy Life of Howard Barnes",
    creator: "Village Theater",
    description: "The music from the musical",
    published_date: "January 1 2018"
  },
  {
    category: "album",
    name: "Storm Front",
    creator: "Billy Joel",
    description: "A cool album",
    published_date: "January 1 1989"
  },
  {
    category: "album",
    name: "Best Shot",
    creator: "Pat Benatar",
    description: "Another cool album",
    published_date: "January 1 1989"
  },
  {
    category: "album",
    name: "America's Greatest Hits",
    creator: "America",
    description: "One of their greatest hits is 'Muskrat Love'",
    published_date: "January 1 1975"
  },
  {
    category: "album",
    name: "Oh, What a Life",
    creator: "American Authors",
    description: "Another cool album",
    published_date: "January 1 2014"
  },
  {
    category: "album",
    name: "Time Capsule - Songs for a Future Generation",
    creator: "The B-52's",
    description: "Another cool album",
    published_date: "January 1 1998"
  },
  {
    category: "album",
    name: "Help!",
    creator: "The Beatles",
    description: "Another cool album",
    published_date: "January 1 1965"
  },
  {
    category: "album",
    name: "The Age of Plastic",
    creator: "The Buggles",
    description: "Welcome to the plastic age",
    published_date: "January 1 2001"
  },
  {
    category: "album",
    name: "A Night to Remember",
    creator: "Cyndi Lauper",
    description: "like a cat",
    published_date: "January 1 1989"
  },
  {
    category: "album",
    name: "Swamp Ophelia",
    creator: "Indigo Girls",
    description: "Another cool album",
    published_date: "January 1 1994"
  },
  {
    category: "album",
    name: "The Very Best of Herman's Hermits",
    creator: "Herman's Hermits",
    description: "my sentimental friend over there...",
    published_date: "January 1 1970"
  }
]

work_failures = []
new_works = []
works_data.each do |work|
  new_work = Work.new
  new_work.category = work[:category]
  new_work.name = work[:name]
  new_work.creator = work[:creator]
  new_work.description = work[:description]
  new_work.published_date = work[:published_date]
  
  successful = new_work.save
  if !successful
    work_failures << new_work
    puts "Failed to save work: #{new_work.inspect}"
  else
    new_works << new_work
    puts "Created work: #{new_work.inspect}"
  end
end

puts "Added #{new_works.count} work records"
puts "(Added #{Work.count} TOTAL work records)"
puts "#{work_failures.length} works failed to save"


users_data = [
  {
    username: "sandi_metz",
    date_joined: "october 13 2019"
  },
  {
    username: "octavia_butler",
    date_joined: "october 14 2019"
  },
  {
    username: "john_scalzi",
    date_joined: "october 15 2019"
  }
]

user_failures = []
users_data.each do |user|
  new_user = User.new
  new_user.username = user[:username]
  new_user.date_joined = user[:date_joined]
  
  successful = new_user.save
  if !successful
    user_failures << new_user
    puts "Failed to save user: #{new_user.inspect}"
  else
    puts "Created user: #{new_user.inspect}"
  end
end

puts "Added #{User.count} user records"
puts "#{user_failures.length} users failed to save"


today_date = Date.parse("2019-10-15")

votes_data = [
  {
    date: today_date,
    user_id: User.find_by(username: "john_scalzi").id,
    work_id: Work.find_by(name: "Spinning Silver").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "octavia_butler").id,
    work_id: Work.find_by(name: "Spinning Silver").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "sandi_metz").id,
    work_id: Work.find_by(name: "Spinning Silver").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "john_scalzi").id,
    work_id: Work.find_by(name: "All Systems Red").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "octavia_butler").id,
    work_id: Work.find_by(name: "All Systems Red").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "john_scalzi").id,
    work_id: Work.find_by(name: "The Name of the Wind").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "octavia_butler").id,
    work_id: Work.find_by(name: "The Name of the Wind").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "john_scalzi").id,
    work_id: Work.find_by(name: "Artificial Condition").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "octavia_butler").id,
    work_id: Work.find_by(name: "Artificial Condition").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "john_scalzi").id,
    work_id: Work.find_by(name: "Uglies").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "octavia_butler").id,
    work_id: Work.find_by(name: "Uglies").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "john_scalzi").id,
    work_id: Work.find_by(name: "Illuminae").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "octavia_butler").id,
    work_id: Work.find_by(name: "Illuminae").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "john_scalzi").id,
    work_id: Work.find_by(name: "Darius the Great Is Not Okay").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "octavia_butler").id,
    work_id: Work.find_by(name: "Darius the Great Is Not Okay").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "john_scalzi").id,
    work_id: Work.find_by(name: "Truly Devious").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "octavia_butler").id,
    work_id: Work.find_by(name: "Truly Devious").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "john_scalzi").id,
    work_id: Work.find_by(name: "Indigo Girl").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "octavia_butler").id,
    work_id: Work.find_by(name: "Indigo Girl").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "john_scalzi").id,
    work_id: Work.find_by(name: "The Hunt for Red October").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "octavia_butler").id,
    work_id: Work.find_by(name: "The Hunt for Red October").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "sandi_metz").id,
    work_id: Work.find_by(name: "The Hunt for Red October").id
  }
]

vote_failures = []
votes_data.each do |vote|
  new_vote = Vote.new
  new_vote.user_id = vote[:user_id]
  new_vote.work_id = vote[:work_id]
  new_vote.date = vote[:date]
  
  successful = new_vote.save
  if !successful
    vote_failures << new_vote
    puts "Failed to save vote: #{new_vote.inspect}"
  else
    puts "Created vote: #{new_vote.inspect}"
  end
end

puts "Added #{Vote.count} vote records"
puts "#{vote_failures.length} vote failed to save"
