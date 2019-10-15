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
  work.published_date = row['publication_year']
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