
## Directory Structure
```
|- app.rb                 # Entry point of the app.
|
|    
|
|- lib
|    |-> errors
     |       |-> CircularDependency         # Custom error for jobs having circular dependency
     |       |-> ItselfDependent            # Custom error for job that depend on itself
|    |-> scheduler                          # The class which will actually schedule our jobs
|
|- spec                   # Test Suite
|    |-> spec_helper      # Load test environment
|    |-> unit             # Contains unit tests
|    |-> integration      # Contains integration tests
|
|- my_input.json          # Input file


```


## Specifications
The project is made using [Ruby](https://www.ruby-lang.org/en/) programming language.

* Ruby Version: 2.5.1
* Gems Required:
  * [RSpec](https://rubygems.org/gems/rspec) : This is used for testing the application
  * [RGL](https://rubygems.org/gems/rgl/versions/0.5.3) : This is used to have graph functionality
  * [Byebug](https://rubygems.org/gems/byebug) : This is used for development purpose



## Running different tasks

1. Change your directory to root directory of this project. Where this readme file is present

2. Run the following commands

* Setup first
    - `bundle install`    # This will install the dependencies

* To run tests
```
    rspec          # Will run both unit and integration tests
```

* To run application
```ruby
    ruby app.rb
```

Input: Make a file `my_input.json` at root of the directory. You can take reference from `my_input_example.json` file.

The output of this will be logged on console, in a form of array, telling us the sequence of jobs to execute .i.e, **left to right.**


## Algorithm
Assumption: The user will give input from a json file named as `./my_input.json`.

I have used **graphs** to schedule the jobs. If there is any cycle in the graph then it will throw the error else it give us the sequence by traversing in **depth first order**. 

In terms of OOPs, I have followed best practices in areas as:

  * Directory Structure: Just like a standard open source project
  * Naming conventions
  * Linting: Followed RuboCop Guidelines
  * __Single responsibility principle__ 

