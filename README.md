# Parsec

Parsec is a natural language parser for addresses. It returns it to you in a simple format.
Create something awesome with it.
We use it for our Rails Rumble Project Happy Geocode. But don't tell it to anyone.

## Installation

Add this line to your application's Gemfile:

    gem 'parsec'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install parsec

## Usage

```ruby
parsed = Parsec.parse "Hauptstraße 23, Köln"

parsed.street_name   #=> Hauptstrasse
parsed.city          #=> Koeln
parsed.street_number #=> 23
parsed.zip           #=> nil
parsed.country       #=> nil
parsed.state         #=> nil
```
