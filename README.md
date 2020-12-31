# Strudel

[![Gem Version](https://badge.fury.io/rb/strudel.svg)](https://badge.fury.io/rb/strudel)
[![CI](https://github.com/justinhoward/strudel/workflows/CI/badge.svg)](https://github.com/justinhoward/strudel/actions?query=workflow%3ACI+branch%3Amaster)
[![Codacy](https://app.codacy.com/project/badge/Grade/79b0e9d0f90c44f2baca0ea4f076ae3a)](https://www.codacy.com/gh/justinhoward/strudel/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=justinhoward/strudel&amp;utm_campaign=Badge_Grade)
[![Inline docs](http://inch-ci.org/github/justinhoward/strudel.svg?branch=master)](http://inch-ci.org/github/justinhoward/strudel)

Strudel is a dependency injection container for Ruby. It's a way to organize
your Ruby application to take advantage of the [dependency inversion
principle][ioc].

## Why another DI framework?

Strudel is not a framework. It's one class that serves as a container only. No
auto-injection. That means no polluting your classes with injection
metaprogramming. You have full, explicit control over how your services
are constructed.

Honestly, you may not even need Strudel or any other DI library. If you are
passing your dependencies through your class constructors, you're already doing
dependency injection! Strudel simply helps you organize your services and
dependencies in one place.

## But Ruby Doesn't Need Dependency Injection!

You may have read [this post][dhh] by David Heineimer Hansson. However he
didn't address the primary benefit of DI, explicitly defining dependencies.
I also happen to think that patching code at runtime for testing is an
anti-pattern worth avoiding.

## Installation

Add this line to your application's Gemfile:

```sh
gem 'strudel'
```

## Getting Started

Fist create a new instance of `Strudel`.

```ruby
require 'strudel'
app = Strudel.new
```

The methods you will use most often are `get` and `set`. These allow you to
create and access services.

```ruby
# Set a static service
app[:api_url] = 'http://example.com/api'

# Set a shared service
app.set(:api) do
  RestApi.new(app[:api_url])
end

# Now we can access the api service
app[:api].request
```

In this example, we set up and use an `api` service.

- First we use the `[]=` method to create a static service called `api_url`.
- Then we create a service called `api`. This time we pass a block into the
  `set` method. This allows the service to be instantiated asynchronously. The
  `RestApi` instance won't be created until we use it on the final line.
- On the last line, we use the `[]` method to retrieve the instance of `RestApi`
  and call a `request` method on it. Because of the way we defined the `api`
  service, the `api.url` parameter will be passed into the `RestApi` constructor
  when it is created.

Once it's constructed, the `api` service will be cached, so if we call it again,
Strudel will use the same instance of `RestApi`.

See the API Documentation for more information or to learn about the other
available methods:

- `[]`
- `[]=`
- `set`
- `factory`
- `protect`
- `extend`
- `each`
- `include?`

## API Documentation

API documentation can be found at [rubydoc.info][docs], or you can generate HTML
documentation with yard.

```sh
bin/yard
```

## Credits

Strudel is a port of the JavaScript library [papaya] by [Justin Howard][justin].

Papaya is originally inspired by [Pimple][pimple], a library for PHP by
[Fabien Potencier][fabien].

## License

The gem is available as open source under the terms of the [MIT
License][mit].

[ioc]: https://en.wikipedia.org/wiki/Dependency_inversion_principle
[dhh]: http://david.heinemeierhansson.com/2012/dependency-injection-is-not-a-virtue.html
[papaya]: https://github.com/justinhoward/papaya
[justin]: https://github.com/justinhoward
[pimple]: http://pimple.sensiolabs.org
[fabien]: https://github.com/fabpot
[mit]: http://opensource.org/licenses/MIT
[docs]: http://www.rubydoc.info/github/justinhoward/strudel
