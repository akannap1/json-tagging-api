# Json-Tagging-Api

### Description 
*  Generic Tagging JSON API that can store, retrieve, delete and report on the usage of a "tag" across different entities

### Setup
* Install latest version of [ruby](https://www.ruby-lang.org/en/documentation/installation/).
* Install rails 4.2.6 [rails](https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-on-ubuntu-14-04-using-rvm)
* Clone the app - `git clone https://github.com/akannap1/json-tagging-api.git`
* Install Bundler - `gem install bundler`
* bundle install (Do it in the Current directory)

### Start json-tagging-Api 
```
- Go to App Directory
- rake db:create 
- rake db:migrate 
- Run `rails s`

```

### Run Tests 
```
- Go to App Direcory
- Run RAILS_ENV=test rake db:create
- Run RAILS_ENV=test rake db:migrate
- Run `rspec spec -f doc` 

```

### Api Request information 

```
Create an Entry
- post  POST /tag
- To create send request in body as json 
- e.g. request {"entity_type": "product", "entity_identifier": "111-33440-222", "tag": ["quantity","price","size"] }

```
```
Retreive Entity Tags for an entity
- GET /tags/:entity_type/:entity_id
```
```
To Retrieve Stats about a specific Entity type
- GET /stats/:entity_type
```
```
To Remove an Entry 
- DELETE /tags/:entity_type/:entity_id
```
```
To Retrieve Stats about all Tags
- GET /stats
```

## Testing the Api 
* Install Postman for testing json-tagging api [Postman](https://www.getpostman.com/)


