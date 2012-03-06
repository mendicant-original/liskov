# Zipline

"The fastest way to get in and out of the Clubhouse"

Zipline is a client library for reading user information from [Clubhouse](https://github.com/mendicant-university/clubhouse)

## Use

Clubhouse only allows read-only access to user data. To connect to a Clubhouse
server, first setup the client's service url:

```ruby
Clubhouse::Client.service_url = "http://myclubhouse.com"
```

Or, if you are using Zipline without a Clubhouse server, first create a json
fixture for your user in `test/fixtures/clubhouse/<USERNAME>.json` replacing
`<USERNAME>` with your github handle.

There is an example fixture named `github_nickname.json.example` in that folder.

Then, using a github handle, lookup a person's information:

```ruby
Clubhouse::Client::Person.new("jordanbyron")
```
