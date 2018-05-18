[![Status](https://travis-ci.org/rstacruz/REPO.svg?branch=master)](https://travis-ci.org/rstacruz/REPO)

# roku-guidelines-app

The roku-guidelines-app really is a simple framework for building Roku applications rapidly. It contains most modules necessary
for creating a roku application using scenegraph. The application follows a MVC architecture overall and we recommend that you
follow a component oriented style of development on top of the MVC to make the application consistent, testable and extentable. The
framework is built with optimization in mind and runs well on low end and high end devices a like.

### Modules contained within the framework are

* A http Module
* Models
* Services
* Controllers
* General Utilites - Type checks and low end device checks
* File utility module
* Focus Manager
* Navigation Stack - History keeper
* Deeplink Integration
* Integrated Test Suite for general files and scenegraph components
* `make` scripts deploying and packaging the application locally
* Files for integrating `CI`. The CI used here is concourse.ci

### Deploying the app locally

To deploy the app locally, you could use the `make` tool. Just make sure to run the `make` from command line on the right directory.
You need to be on the same folder as where the make Makefile exists. You need to set these there parameters first to deploy on to the
roku on the same network.

```
  export ROKU_DEV_TARGET=<<Your Roku IP>>
  export DEVPASSWORD=<<Your Roku Dev Password>>

  // This would be needed if to create the pkg file. Make sure to `rekey` the certificate
  onto the roku device if you are using an existing password that was generated on another roku hardware.

  export APP_KEY_PASS=<<Roku Signing Key Password>>

  // To Install the app locally
  make install

  // To Create a package locally
  make pkg
```

### Running Tests

Once the app is deployed locally, you can get the tests running by passing this command from `cURL` or `postman`

`Method : POST`
`URL: <<YOUR ROKU IP>>:8060/launch/dev?RunTests=true`

You can see the tests results on the debugging console.

### Continous Integration

This project is integrated with [concourse-ci](https://concourse-ci.org/) for continous integration and deployment. The pipeline information
can be found within `pipeline.yml` within the `ci` folder. The credentials.yml file is not included but a sample of what is needed can be
found within `credentials-example.yml`.

The Pipelines at the moment is simple and straightforward. It contains two jobs.

  1) Deploy - Triggers on every commit to this branch. Deploys the application to the test device, runs tests and if tests succeeds.
  It creates a sideloaded build (*.zip) and uploads it to the s3 bucket.

  2) Package - Is manually triggered, This job does not run tests but rather creates a signed package file that can be sent over for
  certification or for updating the private channel.

Both these jobs run of the `develop` branch.

**To Set up your own concourse pipeline just follow the steps below**

##### Step-1

Make sure to install `fly` CLI tools. This package can be downloaded from the ci.tribalscale.com ( This is our concourse-ci server ).

Login into the concourse-ci server and get the `fly tools` downloadable package.

To install fly tools. `fly` is a just a bunch of tools used to control and configure the concourse-ci server locally.

```
install ~/Downloads/fly /usr/local/bin

which fly - this should confirm the existence of fly tool
```

##### Step-2

Login into Concourse Server Instance

```
fly --target ci login --team-name <<Team-Name-Set-On-CI-Server>> --concourse-url <<CONCOURSE-CI-SERVER-URL>>  --insecure
```
The `target` serves as key reference for future pipleline project manipulations
The `team-name` is main

##### Step-3

Create or Update an existing pipeline with credentials information

```
fly --target ci set-pipeline --config pipeline.yml --load-vars-from credentials.yml --pipeline roku-guidelines-app
```

Make sure to run this command from the directory that contains `pipeline.yml` and `credentials.yml`. If the pipeline does not exist on
the server already, it simply updates it.

Doing all the above steps correctly should create new builds and packages and have them saved in s3 amazon bucket. The builds are all versioned by
timestamp.

NOTE: The credentials.yml file contains all the important parameters such as `Roku's IP`, Dev password and the signing key for packages. Make sure that
the roku device and the build server remain on the same network. Builds would fail otherwise.
