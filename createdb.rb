# Set up for the application and database. DO NOT CHANGE. #############################
require "sequel"                                                                      #
connection_string = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite3"  #
DB = Sequel.connect(connection_string)                                                #
#######################################################################################

# Database schema - this should reflect your domain model
DB.create_table! :events do
  primary_key :id
  String :title
  String :description, text: true
  String :date
  String :location
end
DB.create_table! :rsvps do
  primary_key :id
  foreign_key :event_id
  foreign_key :user_id
  Boolean :going
  String :comments, text: true
end
DB.create_table! :users do
  primary_key :id
  String :name
  String :email
  String :password
end

# Insert initial (seed) data
events_table = DB.from(:events)

events_table.insert(title: "Section Picnic", 
                    description: "BYOE(verything) to this socially-distanced picnic!! We will find a large space on the lawn and set up our picnic blankets at least six feet away from each other.",
                    date: "June 15",
                    location: "Deering Lawn")

events_table.insert(title: "Beach Bonfire", 
                    description: "Let's celebrate (outdoors) our last night before we graduate--where else but the beach?!",
                    date: "June 18",
                    location: "Lincoln St. Beach")
