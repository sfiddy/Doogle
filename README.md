# Doogle
Doogle is a dictionary based search engine. 

Check it out [here](https://instant-ink-doogle.herokuapp.com/). 

## Database Design
Doogle's database layer is comprised of two tables with a *one-to-many association* since a 
word can have multiple definitions. 

![Database Design](/app/assets/images/documentation/database_design.png)

## Architecture
### Words

url | action | purpose
:---: | :---: | :---:
/ | new | 
/show | show | page that shows the definition of the new word

----

### Important to note
* `factory_bot_rails` was used instead of `FactoryGirl` given the fact that the latter is deprecated for Rails 5+


### Useful Resources used
* [Nokogiri Cheat Sheet](https://github.com/sparklemotion/nokogiri/wiki/Cheat-sheet)