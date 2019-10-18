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
  work.title = row['title']
  work.creator = row['creator']
  work.publication_date = (row['publication_year'] + "-01-01")
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
    title: "The Name of the Wind",
    creator: "Patrick Rothfuss",
    description: "A good fantasy book",
    publication_date: "January 1 2007"
  },
  {
    category: "book",
    title: "Spinning Silver",
    creator: "Naomi Novik",
    description: "A Russian-inspired fantasy",
    publication_date: "January 1 2018"
  },
  {
    category: "book",
    title: "All Systems Red",
    creator: "Martha Wells",
    description: "A good sci-fi novella",
    publication_date: "January 1 2017"
  },
  {
    category: "book",
    title: "Artificial Condition",
    creator: "Martha Wells",
    description: "A good sci-fi novella",
    publication_date: "January 1 2018"
  },
  {
    category: "book",
    title: "Uglies",
    creator: "Scott Westerfeld",
    description: "A good sci-fi YA book",
    publication_date: "January 1 2005"
  },
  {
    category: "book",
    title: "Darius the Great Is Not Okay",
    creator: "Adib Khorram",
    description: "A comedic contemporary YA book about the son of Iranian immigrants reconnecting with his parent's homeland on a family trip",
    publication_date: "January 1 2018"
  },
  {
    category: "book",
    title: "Life After Life",
    creator: "Jill McCorkle",
    description: "A witty book set at Pine Haven retirement center",
    publication_date: "January 1 2013"
  },
  {
    category: "book",
    title: "Life After Life",
    creator: "Kate Atkinson",
    description: "A dark comedy about a woman who keeps dying over and over again",
    publication_date: "January 1 2013"
  },
  {
    category: "book",
    title: "Truly Devious",
    creator: "Maureen Johnson",
    description: "A YA mystery",
    publication_date: "January 1 2018"
  },
  {
    category: "book",
    title: "Indigo Girl",
    creator: "Natasha Boyd",
    description: "A historical fiction novel",
    publication_date: "January 1 2017"
  },
  {
    category: "book",
    title: "Illuminae",
    creator: "Amie Kaufman",
    description: "A great science fiction story",
    publication_date: "January 1 2016"
  },
  {
    category: "movie",
    title: "The Hunt for Red October",
    creator: "John McTiernan",
    description: "Cold War spy thriller with submarines",
    publication_date: "January 1 1990"
  },
  {
    category: "movie",
    title: "The Women's Balcony",
    creator: "Emil Ben-Shimon",
    description: "Israeli comedy film",
    publication_date: "January 1 2016"
  },
  {
    category: "movie",
    title: "Your Name",
    creator: "Makoto Shinkai",
    description: "Animated Japanese film. You should see it. No spoilers. Just trust me",
    publication_date: "January 1 2017"
  },
  {
    category: "movie",
    title: "Castle in the Sky",
    creator: "Hayao Miyazaki",
    description: "Animated sci-fi movie",
    publication_date: "January 1 1986"
  },
  {
    category: "movie",
    title: "Spirited Away",
    creator: "Hayao Miyazaki",
    description: "Animated fantasy (urban fantasy?) movie",
    publication_date: "January 1 2001"
  },
  {
    category: "movie",
    title: "A New Hope",
    creator: "George Lucas",
    description: "star warssss. the one with the double-sun shot.",
    publication_date: "January 1 1977"
  },
  {
    category: "movie",
    title: "The Empire Strikes Back",
    creator: "George Lucas",
    description: "star warssss. the one with the ice planet",
    publication_date: "January 1 1980"
  },
  {
    category: "movie",
    title: "Return of the Jedi",
    creator: "George Lucas",
    description: "star warssss. the one with the ewoks",
    publication_date: "January 1 1983"
  },
  {
    category: "movie",
    title: "Chitty Chitty Bang Bang",
    creator: "Ken Hughes",
    description: "A fantasy musical. A wild ride",
    publication_date: "January 1 1986"
  },
  {
    category: "movie",
    title: "Monsters, Inc.",
    creator: "Pete Doctor",
    description: "A classic",
    publication_date: "January 1 2001"
  },
  {
    category: "album",
    title: "The Noteworthy Life of Howard Barnes",
    creator: "Village Theater",
    description: "The music from the musical",
    publication_date: "January 1 2018"
  },
  {
    category: "album",
    title: "Storm Front",
    creator: "Billy Joel",
    description: "A cool album",
    publication_date: "January 1 1989"
  },
  {
    category: "album",
    title: "Best Shot",
    creator: "Pat Benatar",
    description: "Another cool album",
    publication_date: "January 1 1989"
  },
  {
    category: "album",
    title: "America's Greatest Hits",
    creator: "America",
    description: "One of their greatest hits is 'Muskrat Love'",
    publication_date: "January 1 1975"
  },
  {
    category: "album",
    title: "Oh, What a Life",
    creator: "American Authors",
    description: "Another cool album",
    publication_date: "January 1 2014"
  },
  {
    category: "album",
    title: "Time Capsule - Songs for a Future Generation",
    creator: "The B-52's",
    description: "Another cool album",
    publication_date: "January 1 1998"
  },
  {
    category: "album",
    title: "Help!",
    creator: "The Beatles",
    description: "Another cool album",
    publication_date: "January 1 1965"
  },
  {
    category: "album",
    title: "The Age of Plastic",
    creator: "The Buggles",
    description: "Welcome to the plastic age",
    publication_date: "January 1 2001"
  },
  {
    category: "album",
    title: "A Night to Remember",
    creator: "Cyndi Lauper",
    description: "like a cat",
    publication_date: "January 1 1989"
  },
  {
    category: "album",
    title: "Swamp Ophelia",
    creator: "Indigo Girls",
    description: "Another cool album",
    publication_date: "January 1 1994"
  },
  {
    category: "album",
    title: "The Very Best of Herman's Hermits",
    creator: "Herman's Hermits",
    description: "my sentimental friend over there...",
    publication_date: "January 1 1970"
  }
]

work_failures = []
new_works = []
works_data.each do |work|
  new_work = Work.new
  new_work.category = work[:category]
  new_work.title = work[:title]
  new_work.creator = work[:creator]
  new_work.description = work[:description]
  new_work.publication_date = work[:publication_date]
  
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
    work_id: Work.find_by(title: "Spinning Silver").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "octavia_butler").id,
    work_id: Work.find_by(title: "Spinning Silver").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "sandi_metz").id,
    work_id: Work.find_by(title: "Spinning Silver").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "john_scalzi").id,
    work_id: Work.find_by(title: "All Systems Red").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "octavia_butler").id,
    work_id: Work.find_by(title: "All Systems Red").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "john_scalzi").id,
    work_id: Work.find_by(title: "The Name of the Wind").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "octavia_butler").id,
    work_id: Work.find_by(title: "The Name of the Wind").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "john_scalzi").id,
    work_id: Work.find_by(title: "Artificial Condition").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "octavia_butler").id,
    work_id: Work.find_by(title: "Artificial Condition").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "john_scalzi").id,
    work_id: Work.find_by(title: "Uglies").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "octavia_butler").id,
    work_id: Work.find_by(title: "Uglies").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "john_scalzi").id,
    work_id: Work.find_by(title: "Illuminae").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "octavia_butler").id,
    work_id: Work.find_by(title: "Illuminae").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "john_scalzi").id,
    work_id: Work.find_by(title: "Darius the Great Is Not Okay").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "octavia_butler").id,
    work_id: Work.find_by(title: "Darius the Great Is Not Okay").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "john_scalzi").id,
    work_id: Work.find_by(title: "Truly Devious").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "octavia_butler").id,
    work_id: Work.find_by(title: "Truly Devious").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "john_scalzi").id,
    work_id: Work.find_by(title: "Indigo Girl").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "octavia_butler").id,
    work_id: Work.find_by(title: "Indigo Girl").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "john_scalzi").id,
    work_id: Work.find_by(title: "The Hunt for Red October").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "octavia_butler").id,
    work_id: Work.find_by(title: "The Hunt for Red October").id
  },
  {
    date: today_date,
    user_id: User.find_by(username: "sandi_metz").id,
    work_id: Work.find_by(title: "The Hunt for Red October").id
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
