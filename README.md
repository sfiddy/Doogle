# Doogle
Doogle is a dictionary based search engine. 

Check it out [here](https://instant-ink-doogle.herokuapp.com/). 

## Database Design
Doogle's database layer is comprised of two tables with a *one-to-many association* since a 
word can have multiple definitions. 

![Database Design](/app/assets/images/documentation/database_design.png)

----

### Important to note
* `factory_bot_rails` was used instead of `FactoryGirl` given the fact that the latter is deprecated for Rails 5+
* Features Specs testing javascript has been disabled due to the inability to successfully install the Selenium driver in a cloud interface. I would get the following error when attempting to run the selenium driver:
```ruby
Failure/Error: visit "/"

Selenium::WebDriver::Error::UnknownError:
 unknown error: cannot find Chrome binary
   (Driver info: chromedriver=2.42.591071 (0b695ff80972cc1a65a5cd643186d2ae582cd4ac),platform=Linux 4.14.62-65.117.amzn1.x86_64 x86_64)
```

### Useful Resources used
* [Nokogiri Cheat Sheet](https://github.com/sparklemotion/nokogiri/wiki/Cheat-sheet)
* [RSpec Expectations Cheat Sheet](https://www.rubypigeon.com/posts/rspec-expectations-cheat-sheet/)