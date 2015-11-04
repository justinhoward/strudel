# Strudel

[![Build Status](https://travis-ci.org/justinhoward/strudel.svg?branch=master)]
(https://travis-ci.org/justinhoward/strudel)
[![Code Climate](https://codeclimate.com/github/justinhoward/strudel/badges/gpa.svg)]
(https://codeclimate.com/github/justinhoward/strudel)
[![Test Coverage](https://codeclimate.com/github/justinhoward/strudel/badges/coverage.svg)]
(https://codeclimate.com/github/justinhoward/strudel/coverage)

Strudel is a dependency injection container for Ruby. It's a way to organize
your Ruby application to take advantage of the [dependency inversion
principle][ioc].

## Why another DI framework?

Strudel is not a framework. It's one class that serves as a container only. No
auto-injection. That means no polluting your classes with garbage injection
metaprogramming. You have full, explicit control over how your services
are constructed.

Honestly, you may not even need Strudel or any other DI library. If you are
passing your dependencies through your class constructors, you're already doing
dependency injection! Strudel simply helps you organize your services and
dependencies in one place.

## But Ruby Doesn't Need Dependency Injection!

You may have read [this post][dhh] by David Heineimer Hansson. However he
didn't address the primary benefit of DI, explicitly defining dependencies.
I also happen to think that patching code at runtime for testing is a egregious
anti-pattern.  In case you need more convincing, check out this [great post] by
Piotr Solnica.

## Installation

Add this line to your application's Gemfile:

```sh
gem 'strudel'
```

## Getting Started

## Reference

## Credits

Strudel is a port of the JavaScript library [papaya] by [Justin Howard][justin].

Papaya is originally inspired by [Pimple][pimple], a library for PHP by
[Fabien Potencier][fabien].

## License

The gem is available as open source under the terms of the [MIT
License][mit].

[ioc]: https://en.wikipedia.org/wiki/Dependency_inversion_principle
[dhh]: http://david.heinemeierhansson.com/2012/dependency-injection-is-not-a-virtue.html
[piotr]: http://solnic.eu/2013/12/17/the-world-needs-another-post-about-dependency-injection-in-ruby.html
[papaya]: https://github.com/justinhoward/papaya
[justin]: https://github.com/justinhoward
[pimple]: http://pimple.sensiolabs.org
[fabien]: https://github.com/fabpot
[mit]: http://opensource.org/licenses/MIT
