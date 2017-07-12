# Command-line-tool

Description 
* Simple Command line tool for search

ProjectSetup Instructions
* Install ruby latest version (Supports ruby version anything above ruby-2.3.1)
* Install ruby using doc: https://www.phusionpassenger.com/library/walkthroughs/deploy/ruby/ownserver/nginx/oss/install_language_runtime.html
* Clone the app - 'git clone https://github.com/akannap1/command-line-tool.git'
* Run 'gem install bundler' (install bundler for us)
* bundle install (Do it in the Current directory)

Start Command-line-Application 
* Go to App Directory
* Run "ruby -r './main.rb' -e 'Main.run'"

Run Tests 
* Go to App Direcory
* Run 'rspec spec' 

Assumptions
* data all is in json 
* number of keys are constant throughout the data

Features 
* New data can be added by inputting json files in json_data directory
* You can read through all the specs by doing 'rspec spec -f doc'
