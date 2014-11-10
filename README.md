# Stackflame

Stackflame provides a simple API to deal with Flamegraph of [stackprof](https://github.com/tmm1/stackprof).

## Installation

```bash
$ gem install stackflame
```

## Usage

```ruby
require "stackflame"

Stackflame.profile do
  1000.times { User.all.to_a }
end
```

## License

MIT License
