# HRA Calculator


## Setup
The HRA Calculator is a Dockerized project.  You will need to download and install the [Docker Desktop for Mac](https://docs.docker.com/docker-for-mac/install/) in order to use and develop the code.

In the directory where you have cloned the repo, run the following command to configure Webpacker to run as a separate service:

```
$ docker-compose run runner ./bin/setup
```

Next, create docker containers for the service dependencies.  Note that the following two commands will both start a rails server running on localhost:3000.  The difference is the first command will run the server process in the terminal window (where log output may be observed) while the second command will daemonize the server in its own background process.  

```
$ docker-compose up --build rails
```

```
$ docker-compose up -d --build rails
```

You can stop the server running in background:

```
$ docker-compose stop rails
```

## Helpful Docker Commands

Following are some useful commands to manage your Docker environment.  These commands must be run in the project directory.


Initiate a terminal session in the Docker container context:

```
$ docker-compose run runner
```

Enter CTRL-D to exit the terminal session

Get a list of active containers

```
$ docker-compose ps
```

See log file output for the application and dependent services

```
$ docker-compose logs
```

Start and stop application and all dependent container services.  These commands work after the containers are created following successful execution of the ```docker-compose up``` command above.

```
$ docker-compose start
$ docker-compose stop
```


## Configuration

* Ruby 2.6.3
* Rails 6.0 w/options:
  * --skip-action-cable
  * --skip-active-record
  * --skip-test
  * --skip-system-test
  * --webpack-=angular
* Dependencies
  *  Webpacker
  *  MongoDb 4.2
  *  Redis

## Frontend UI

  The frontend uses the Angular framework to handle user interactions and is built using the Angular-cli generator.

  To get started do the following:

  ```
  cd clients/html && npm install
  ```

  You can start the Angular Live Development Server with:

  ```
  ng serve
  ```

  Now you can visit [`localhost:4200`](http://localhost:4200) from your browser.

## Helpful UI Resources

  [`Angular`](https://angular.io/)

  [`Angular cli`](https://cli.angular.io/)

  [`Monster Angular Dashboard Template`](https://www.wrappixel.com/demos/angular-admin-templates/monster-angular/docs/documentation.html)
