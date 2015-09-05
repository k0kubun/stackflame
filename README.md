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
  # some code to profile
  100.times { User.create }
end
```

If you use OSX, flamegraph will be opened with your default browser.

![](http://i.gyazo.com/47871c2de985298c61d0fcca041a34d0.png)

### Rack middlware

```ruby
use Rack::Stackflame, interval: 10
```

## License

MIT License
