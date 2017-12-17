# README

Given a dynamic CSV datasource containing a list of different banks, tenure in months,
interest rates, and minimum loan amount:

1. Write a function that will return the data in a prescribed JSON structure (see below)

2. Write a web app, in your choice of language/framework, which would serve that info
at the url emi-schemes filtered for amount provided as a GET param (e.g. /emischemes?
amount=10000 ). 

The end point should return all the emi schemes that can be
availed for the given amount.

JSON STRUCTURE
===============

```
[{
	"bank": "HDFC",
	"tenures": [{
		"months": 3,
		"rate": 13,
		"minimum_amount": 3000
	}]
}]
```

Steps For Application:

* Ruby version - 2.3.1

* Initialise application: bundle install, rails s

* Database creation- rake db:create, rake db:migrate

* How to run the test suite: bundle exec rspec

* endpoints for the application:

1. Create emi schemes data from csv
```
http :3000/emi-schemes-info-create

```

2. For emi-schemes that are eligible

```
 http :3000/emi-schemes?amount=10000
 
```
3. For web the url is : ```http://localhost/emi-schemes?amount=10000```

Check Server Logs for more information on each endpoint actions
