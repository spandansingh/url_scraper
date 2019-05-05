URL Scraper Microservice
===============

It is a scalable microservice which scrapes the urls and stores its response. We can setup it using the following two methods.

### First Method - Using [Docker Compose](https://docs.docker.com/compose/)

The recommended way to install URL Scraper microservice is through
[Docker Compose](https://docs.docker.com/compose/).

```bash
# Clone the Repository
git clone https://github.com/spandansingh/url_scraper.git
```
### Build & Run

```bash
docker-compose up --build -d
```
Yay! Everything is now up and running. It will now build and run three services in separate docker containers - 

* Microservice ( [Lumen Micro-Framework](https://lumen.laravel.com) - The stunningly fast micro-framework by Laravel )
    * [worker](https://github.com/spandansingh/url_scraper/blob/master/app/app/Console/Commands/UrlScraper.php) to process the URLs 
    * HTTP Server to expose the [API](https://github.com/spandansingh/url_scraper/blob/master/app/app/Http/Controllers/UrlController.php) to see the report of the failed urls
* Database Server (MySQL)
* Database Client (PhpMyAdmin)

which can be listed by the following command-

```bash
docker-compose ps
```

Docker compose creates a local network between these containers. 

If the worker failed to scrape any url it retries to scrape it. 
The Threshold number of retries could be modified by changing the environment variable RETRIES_THRESHOLD inside the docker-compose.yml.
Default number of retries is 3. In the docker-compose.yml, we can also modfiy other environment variables like database credentials.

Docker Compose automatically pulls the [docker image](https://hub.docker.com/r/spandy/url_scraper). However, the docker image could also built locally using the Dockerfile inside the root folder. 
Run the following command to build the docker image locally.

```bash
docker build -t spandy/url_scraper .
```

Let's populate some urls in database now!! Please navigate to phpmyadmin which is running at http://localhost:8181. 

Create a database moveinsync and import the [sql file](https://raw.githubusercontent.com/spandansingh/url_scraper/master/moveinsync.sql) that is in the root folder of this repository.
 
Note: Since worker is already running so you will be able to see the results inside the table.

API to get the report for the failed urls - http://localhost:8000/urls/failed


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


## Second Method - Using [Composer](http://getcomposer.org)

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

Now, set the MySQL database credentials in the app/.env file to connect with database.

Please find the exported [sql file](https://raw.githubusercontent.com/spandansingh/url_scraper/master/moveinsync.sql) in the root folder.

The Threshold number of retries could be modifiled by changing the environment variable RETRIES_THRESHOLD inside the /app/.env file
Default number of retries is 3. 

Now, change the directory to /app and start the worker to process urls by running the following command. 

```bash
# Start the worker
php artisan moveinsync:url_scraper
```

Now open another terminal instance and start the http server.

```bash
# Start the HTTP Server
php -S localhost:8000 -t public
```

To get the report of failed urls use the api - http://localhost:8000/urls/failed 
