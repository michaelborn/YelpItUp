# YelpItUp

A sample Elasticsearch app using the [Yelp dataset](https://www.yelp.com/dataset/), [Coldbox](https://www.coldbox.org/), and [CBElasticsearch](https://cbelasticsearch.ortusbooks.com/).

![YelpItUp app showing sample Yelp reviews for "toast"](screenshot-search-results.png)

For a full description of how this app works, check out my ITB 2020 CBElasticsearch talk [presentation](https://slides.com/michaelborn/power-up-with-cbelasticsearch#/) or [github repo](https://github.com/michaelborn/ITB2020-CBElasticsearch-talk).

## Getting Started

1. Clone this repo - `git clone git@github.com:michaelborn/YelpItUp.git`
2. [Install CommandBox if you don't have it](https://commandbox.ortusbooks.com/getting-started-guide)
3. Download the [Yelp dataset](https://www.yelp.com/dataset) and extract to `resources/downloads/`
4. Install dependencies - `box install`
5. Start up a docker Elasticsearch container - `docker run -d -p 9200:9200 -e "discovery.type=single-node" elasticsearch:7.6.2`
6. Start this app - `box start`

## The Good News

> For all have sinned, and come short of the glory of God ([Romans 3:23](https://www.kingjamesbibleonline.org/Romans-3-23/))

> But God commendeth his love toward us, in that, while we were yet sinners, Christ died for us. ([Romans 5:8](https://www.kingjamesbibleonline.org/Romans-5-8))

> That if thou shalt confess with thy mouth the Lord Jesus, and shalt believe in thine heart that God hath raised him from the dead, thou shalt be saved. ([Romans 10:9](https://www.kingjamesbibleonline.org/Romans-10-9/))
 
## Repository

Copyright 2020 (and on) - [Michael Born](https://michaelborn.me/)

* [Homepage](https://bitbucket.org/michaelborn_me/cfevents/src/master/)
* [Issue Tracker](https://bitbucket.org/michaelborn_me/cfevents/issues?status=new&status=open)
* [New BSD License](https://bitbucket.org/michaelborn_me/cfevents/src/master/LICENSE.txt)

[![cfmlbadges](https://cfmlbadges.monkehworks.com/images/badges/made-with-cfml.svg)](https://cfmlbadges.monkehworks.com) [![cfmlbadges](https://cfmlbadges.monkehworks.com/images/badges/tested-with-testbox.svg)](https://cfmlbadges.monkehworks.com) [![cfmlbadges](https://cfmlbadges.monkehworks.com/images/badges/powered-by-coffee.svg)](https://cfmlbadges.monkehworks.com) [![cfmlbadges](https://cfmlbadges.monkehworks.com/images/badges/i-can-bench-press-ben-nadel.svg)](https://cfmlbadges.monkehworks.com)