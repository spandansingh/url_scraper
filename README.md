Url Scraper Microservice
===============

It is a scalable microservice which scrape the urls and stored its response. We can setup it using the following methods-

### Installing via docker-compose

The recommended way to install Url Scraper microservice is through
[Docker-Compose](https://docs.docker.com/compose/).

```bash
# Clone the Repository
git clone https://github.com/spandansingh/url_scraper.git
```
### Build & Run

```bash
docker-compose up --build -d
```
Yay! Everything is now up and running. It will create three services - 

* Microservice
    * worker to process the URLs
    * HTTP Server to expose the API to see the report of the failed urls
* Database Server
* Database Client

Now go to phpmyadmin which is running at http://localhost:8181 and import the sql file that is in the root folder of this repository.

Note: Since worker is already running so you will be able to see the results inside the table.

### Database default credentails

```bash
Username - root
Password - moveinsync
Database - moveinsync
```

### Stop Everything

```bash
docker-compose down
```


## Installing via Composer

The another way to install Url Scraper microservice is through
[Composer](http://getcomposer.org).

```bash
# Clone the Repository
git clone https://github.com/spandansingh/url_scraper.git
```

```bash
# Install composer
curl -sS https://getcomposer.org/installer | php
```

Next, run the composer command inside the /app folder. 

```bash
# Install dependencies
composer install
```

Now, set the mysql database credentials in the app/.env file to connect with database.
Please find the exported sql file in the root folder.

Threshold number of retries could be modifiled by changing the environment variable RETRIES inside the /app/.env file
Default number of retries is 3. 
Now, change the directory to /app and start the worker to process urls by running the following command. 
```bash
# Start the worker
php artisan moveinsync:url_scraper
```

Now open another terminal instance and run the following to get the report of failed urls.

```bash
# Start the HTTP Server
php -S localhost:8000 -t public
```

Note : The report for the failed urls will be accessible at http://localhost:8000/urls/failed
