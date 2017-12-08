# Read This before you run it

#Take-Home-Final

#WEIWEI SU
#U17420699
#ReadMe

Framework: Sinatra, Bootstrap

Database: MySQL

API & Libraries: Google Charts JS, jQuery

Language: Ruby, HTML, JavaScript with AJAX, JSON

Because this is a Database-backed Ruby Application, there's a few things you should done before you try to run it.

# Step 1:
Import the `database.sql` file to your Database, in this instance I used MySQL. (Also the App)

# Step 2:
Open `main.rb`, under `line 12`
Reconfig the database connection parameters to make it able to connect to your MySQL database.
(I did not use `database.yml` so sorry no prompt window)

# Step 3:
In console (or cmd in Windows)
under the project folder
run `bundle install` (Install `bundle` gem first if you have not installed it)

# Step 4:
Just compile the `main.rb`

# Step 5:
Open your Browser and enter the `localhost:port` where set by Ruby Sinatra and you are good to go!

# Reminder: Everytime then the app first started the Chart won't be drawn. You have to enter the name first.
