# Baby House

Site of Baby House School

## Development Environment


You'll need [RVM][] to isolate your development environment.

Make sure you install `Ruby 1.9.3` on your [RVM][].

Then just checkout the code, configure dependencies and run the tests:

1. Clone the repository:

 `git clone git://github.com/josemarluedke/baby_house.git`

2. Enter the repo directory and accept the [RVM][]:

 `cd baby_house`

 `yes`

3. Install [Bundler][] into our [RVM][]:

 `gem install bundler`

4. Install all dependencies from [Gemspec][]:

 `bundler install`


## Setup Development and Test Databases


1. Create your database.yml:

	`cp config/database.sample.yml config/database.yml`

2. Create the local databases:

	`bundle exec rake db:create`

2. Create the tables:

	`bundle exec rake db:migrate`

4. Create the default configs

	```
export sendgrid_username=your_sendgrid_username
export sendgrid_password=your_sendgrid_password
	```

[rvm]: https://rvm.io/
[bundler]: http://gembundler.com/
[Gemspec]: http://docs.rubygems.org/read/chapter/20
