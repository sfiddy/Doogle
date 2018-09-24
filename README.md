# Doogle
Doogle is a dictionary based search engine. 

Check it out [here](https://instant-ink-doogle.herokuapp.com/). 

## Database Design
Doogle's database layer is comprised of two tables with a one-to-many association since a 
word can have multiple definitions. 

![Database Design](/app/assets/images/documentation/database_design.png)

## Architecture
### Words

url | action | purpose
:---: | :---: | :---:
/ | new | the landing page & page to search for new word
/show | show | page that shows the definition of the new word
 
 