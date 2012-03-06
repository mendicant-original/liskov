# Liskov (University Web 2.0)

Liskov is a reboot of University Web, Mendicant University's course management
application.

## Contributing

**We are currently not accepting patches for Liskov. Watch this repo for
more information.**

## Installation

Liskov is a Ruby on Rails 3.2 application which runs on Ruby 1.9.2+ and
[PostgreSQL](http://www.postgresql.org) databases.

### Setting Up a Development Copy: Step by Step

To install a development version of Community, follow these steps:

1. Fork our GitHub repository: <http://github.com/mendicant-university/liskov>
2. Clone the fork to your computer
3. If you don't already have bundler installed, get it by running
   `gem install bundler`
4. Run `bundle install` to install all of the project's dependencies
5. Finally, run `rake setup` to create the required config files, create the
   database, and seed it with data

To make things even easier, you can copy and paste this into your terminal once you've got the project cloned to your computer

```
gem install bundler
bundle install
bundle exec rake setup
```

## License

Liskov is released under the [Affero GPL version 3](http://www.gnu.org/licenses/agpl.html).

If you wish to contribute to Liskov, you will retain your own copyright but must agree to license your code under the same terms as the project itself.

------

Liskov - a [Mendicant University](http://mendicantuniversity.org) project