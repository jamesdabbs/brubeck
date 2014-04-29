# 𝜋-Base

See the live site at [topology.jdabbs.com](http://topology.jdabbs.com).

[![Build Status](https://travis-ci.org/jamesdabbs/pi-base.png)](https://travis-ci.org/jamesdabbs/pi-base)
[![Code Climate](https://codeclimate.com/github/jamesdabbs/pi-base.png)](https://codeclimate.com/github/jamesdabbs/pi-base)

### Testing locally

To run locally, you will need to install the following dependencies:

* postgres
* ruby 2.0 (recommended through [rbenv](https://github.com/sstephenson/rbenv/))
* redis

Then run the following:

```bash
$ git clone git@github.com:jamesdabbs/pi-base.git
$ cd pi-base
$ bundle          # Installs gem packages as specified in the Gemfile
$ rake db:setup   # Creates the database, with its required tables
```

At this point you should be set up to use any of these commands:

```bash
$ rails c           # Starts an interactive rails console session
$ rails s           # Spins up a rails server at localhost:3000
```

If you have other gems installed on your system, you may need to prefix `rake` and `rails` commands with `bundle exec`.

Feel free to email me if you have any trouble getting things up and running.

### Contributing

I would _love_ bug reports and feature requests. Feel free to submit those in the [GitHub issues](https://github.com/jamesdabbs/pi-base/issues).

If you want to push up code, open up a pull request. I'll review it, merge it in, and push it live once it's good to go.

### TODO

* Fix display of conjunctions
* Get proof tracing visualization working and enabled (and fix link on homepage)
  - "automated deduction" and "follow along"
* Resolve DNS

* Finish updating styling throughout
  - Trait index
  - Sticky footer
  - Search box
* Develop and support ?/Unknown search syntax; update example on frontpage ("search")
* Figure out why trait specs are failing when run en masse, but not individually
* Prefetch all relevant traits when checking a theorem against a space
* Stress test sucker_punch
* Score ES name hits higher than description hits
* Styling
  - Check icons, general checking
  - Fixed footer
  - Style login pages
