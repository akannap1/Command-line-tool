# Command-line-tool

### Description 
* Simple Command line tool for searching through json files

### Setup
* Install latest version of [ruby](https://www.ruby-lang.org/en/documentation/installation/).
* Clone the app - `git clone https://github.com/akannap1/command-line-tool.git`
* Install Bundler - `gem install bundler`
* Install the required gems/libraries - `cd <project_root>; bundle install`

### Start Command-line-Application 
* Go to App Directory
* Run `ruby -r './main.rb' -e 'Main.run'`

### Run Tests 
* Go to App Direcory
* Run `rspec` 

### Assumptions
* All the data is in json
* All the elements in the json data contain the same keys i.e keys without no value
  should be explicitly defined with null

### Features 
* Lists all the fields that are searchable for a json file
* In addition to the data provided, the application can be extended to search through new data by adding the relevant json file in the "<project_root>/json_data" directory
