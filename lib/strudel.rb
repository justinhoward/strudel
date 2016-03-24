# Strudel
#
# A tiny dependency injection container
class Strudel
  # Creates a new Strudel container
  #
  # @yield [self]
  def initialize
    @services = {}
    @procs = {}
    @factories = {}
    yield self if block_given?
  end

  # Get a service by key
  #
  # If the service is not set, returns +nil+.
  #
  # @param [key] key The service key
  # @return [value, nil] The service or nil if not set
  def [](key)
    return @services[key].call(self) if @factories[key]

    if @procs[key]
      @services[key] = @services[key].call(self)
      @procs.delete(key)
    end

    @services[key]
  end

  # Set a service by key and value
  #
  # If +service+ is a Proc, its return value will be treated as a
  # singleton service meaning it will be initialized the first time it is
  # requested and its valud will be cached for subsequent requests.
  #
  # Use the +set+ method to allow using a block instead of a Proc argument.
  #
  # If +service+ is not a function, its value will be stored directly.
  #
  # @param [key] key The service key
  # @param [Proc, value] service The service singleton Proc or static service
  # @return [self]
  def []=(key, service)
    set(key, service)
  end

  # Set a service by key and value
  #
  # Same as +[]=+ except allows passing a block instead of a Proc argument.
  #
  # @param [key] key The service key
  # @param [Proc, value, nil] service The service singleton Proc or static
  #   service
  # @yield [self]
  # @return [self]
  def set(key, service = nil)
    create(key, service || Proc.new, @procs)
  end

  # Set a factory service by key and value
  #
  # If +factory+ is a function, it will be called every time the service is
  # requested. So if it returns an object, it will create a new object for
  # every request.
  #
  # If +factory+ is not a function, this method acts like +set+.
  #
  # @param [key] key The service key
  # @param [Proc, block] factory The service factory Proc or static service
  # @yield [self]
  # @return [self]
  def factory(key, factory = nil)
    create(key, factory || Proc.new, @factories)
  end

  # Set a protected service by name and value
  #
  # If +service+ is a function, the function itself will be registered as a
  # service. So when it is requested with +get+, the function will be returned
  # instead of the function's return value.
  #
  # If +service+ is not a function, this method acts like +set+.
  #
  # @param [key] key The service key
  # @param [Proc, value, nil] service The service function.
  # @yield [self]
  # @return [self]
  def protect(key, service = nil)
    create(key, service || Proc.new)
  end

  # Extends an existing service and overrides it.
  #
  # The +extender+ block will be called with 2 arguments: +old_value+ and
  # +self+. If there is no existing +key+ service, +old_value+ will be nil. It
  # should return the new value for the service that will override the existing
  # one.
  #
  # If +extend+ is called for a service that was created with +set+, the
  # resulting service will be a singleton.
  #
  # If +extend+ is called for a service that was created with +factory+, the
  # resulting service will be a factory.
  #
  # If +extend+ is called for a service that was created with +protect+, the
  # resulting service will also be protected.
  #
  # If +extender+ is not a function, this method will override any existing
  # service like +set+.
  #
  # @param [key] key The service key
  # @param [Proc, value, nil] extender
  # @yield [old_value, self]
  # @return [self]
  def extend(key, extender = nil)
    extender ||= Proc.new
    return set(key, extender) unless extender.is_a?(Proc) && @services.key?(key)

    extended = @services[key]
    call = @factories[key] || @procs[key]
    send(@factories[key] ? :factory : :set, key) do
      extender.call(self, call ? extended.call(self) : extended)
    end
  end

  # Iterates over the service keys
  #
  # If a block is given, the block is called with each of the service keys
  # If a block is not given, returns an +Enumerable+ of the keys.
  #
  # The key order is undefined.
  #
  # @yield [key] Gives the key
  # @return [Enumerable, nil]
  def each
    return @services.each_key unless block_given?
    @services.each_key { |key| yield key }
  end

  # Checks if a service for +key+ exists.
  #
  # @return [bool] True if the service exists.
  def include?(key)
    @services.key?(key)
  end

  private

  # Create a service
  #
  # @param [key] key The service key
  # @param [value] service The service value or factory
  # @param [Hash] registry If the service is a proc, the registery
  def create(key, service, registry = nil)
    [@procs, @factories].each { |reg| reg.delete key }
    registry[key] = true if registry && service.is_a?(Proc)
    @services[key] = service
    self
  end
end
