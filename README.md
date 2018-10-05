# Doogle
Doogle is a dictionary based search engine. 

Check it out [here](https://instant-ink-doogle.herokuapp.com/).

You can access rails admin by visiting [https://instant-ink-doogle.herokuapp.com/admin](https://instant-ink-doogle.herokuapp.com/admin)


## Questions for you
- I was unable to test my feature specs given the fact that I wasn't able to downlaod 
the Selenium driver to a cloud IDE. Can you guys give me some feedback on my feature specs?

----------

## Implementation
The file directory below shows the project structure for the most important files.
```
.
├── app 
│   ├── controllers
│   │   └── words_controller.rb             # Core definition search logic lives in words#create.
│   │
│   ├── models
│   │   ├── admin.rb                        # Model for Rails Admin. No custom code added.
│   │   ├── definition.rb                   # Model for definitions tables. It belongs to Word. 
│   │   └── word.rb                         # Model for word table. It can have many definitions
│   │
│   ├── views
│   │   ├── devise                          # All views for auth for rails admin lives here.
│   │   └── words                           # All views for word search logic lives here.
│   │       ├── _form.html.erb              # Word search form
│   │       ├── new.html.erb                # Landing page
│   │       └── create.js.erb               # Word & definitions are rendered to the landing page via jquery 
│   │
│   ├── config
│   │   └── application.yml                  # Dictionary API token lives here.
│   │
│   ├── lib
│   │   └── web_services           
│   │       └── dictionary_api.rb            # API call & payload processing happens here.
│   │ 
│   ├── spec
│   │   ├── controllers          
│   │   │   └── words_controller_spec.rb     # Spec for words_controller. Focus on specs for POST#create.
│   │   ├── features          
│   │   │   ├── rails_admin_feature_Spec.rb  # Feature Spec that tests rails admin login/signin functionality
│   │   │   └── word_search_feature_spec.rb  # Feature Spec that tests word search functionality
│   │   ├── lib          
│   │   │   └── web_services         
|   │   │       └── dictionary_api_spec.rb   # Spec that tests external api call 
│   │   ├── models          
│   │   │   ├── definition_spec.rb           # Model spec for Definition. Only tests for association & validation
│   │   │   └── word_spec.rb                 # Model spec for Word. 
│   │   ├── routing          
│   │   │   └── words_routing_spec.rb        # Tests that the routes are set up correctly. Does not test rails admin routes
│   │ 
│   └── ...                 # etc.
└── ...

```


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