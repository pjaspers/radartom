# Radar Tom

`dish.rb`

This is the small script to fetch all mentions on all the twitters, it dumps them to our database. `bundle exec rake crawl_for_tag` will run it.

It requires the following `ENV` variables to be set (in development, use a `.env`-file)

```
TWITTER_CONSUMER_KEY=""
TWITTER_CONSUMER_SECRET=""
TWITTER_OAUTH_TOKEN=""
TWITTER_OATH_TOKEN_SECRET=""
```

(available by registering your app at https://apps.twitter.com)

`config.ru`

Since radartom.io is already live, but showing another thing, the `config.ru` defines two apps, one is the old, one is `Broechem`.

To test out the new site, you can visit `http://radartom.io/?bob=stinkt`, in development you can visit the new site by setting an `UNLEASH_THE_KRAKEN=GO` env variable.

`broechem.rb`

Main web app to host all the things, barebones Sinatra app with:

- The best asset pipeline ever! (**coughs**run the app in development and
  commit the compiled stylesheet to the repo**coughs**)
- The best CSS grid system ever! (read: I hacked this together, at least it's
  small. Fewer lines of code is fewer lines of bugs, right?)
- The most advanced unicorn configuration ever! (copy/pasted it from
  Heroku)
- An extensive test suite! (e.g. one test that checks for a 200)

Either run `foreman start` or run `gem install shotgun && shotgun config.ru`.

Feist your eyes on:

![DOTTER](https://pile.pjaspers.com/Screen-Shot-2015-09-07-at-23.14.21-0gZF6jpKXV.png)

## Deploying

Ping @fousa to get access to the heroku app that's running this.
