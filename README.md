# Restbucks UI

This is the accompaining UI for the [Ruby restbucks UI](https://github.com/JordiPolo/restbucks-ui).

It consumes and allow the user to interact with the workflow presented
in the [original restbucks article](http://www.infoq.com/articles/webber-rest-workflow).

This was created to try to get some understanding on how to use
hypermedia in the real world. Cowboy coding with no tests.

# Setup
Do this, and have the UI running to access it.
```
bundle install
bundle exec rake config
bundle exec rake db:migrate
bundle exec rails s
```
