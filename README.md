
4 API Benchmarks
================

Four different app architectures for benchmarking concurrent API designs:

* Rails 4 + MySQL 
* Rails 4 + MongoDB 
* Goliath + MySQL
* Goliath + MongoDB

Usage
-----

Each mini-app contains either a `config/database.yml` (Rails/MySQL), `config/mongoid.yml` (Rails/Mongo), `db/mongoid.yml` (Goliath/Mongo), or a `db/config.yml` (Goliath/MySQL) for initializing database connections. Alter these as necessary.

You might notice that I ended up sharing the config for MySQL between two apps; and I did the same for MongoDB. This was just because I'm lazy and didn't want to recreate a 1,000,000 record database for each of the 4 benchmark apps. Creating only 2 (one in sql, one in mongo) was simpler.

You will likely need to run `rake db:migrate` for setting up your first MySQL database. For MongoDB, it's Mongo, so it will auto-create the db when you first run a query against it.

Setting up the Test Corpus
--------------------------

You want 1,000,000 rows to benchmark against. Easiest way: use console and manually run the `Item.generate_million` command.

NOTE: you only have to do this once for each of the two database types (mysql vs mongo) if you are sharing them the way I did.
 