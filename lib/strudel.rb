class Strudel
  include Enumerable

  def initialize
    @services = {}
    @procs = {}
    @factories = {}
    yield self if block_given?
  end

  def [](key)
    return @services[key].call(self) if @factories[key]

    if @procs[key]
      @services[key] = @services[key].call(self)
      @procs.delete(key)
    end

    @services[key]
  end

  def []=(key, service)
    set(key, service)
  end

  def set(key, service = nil)
    create(key, service || Proc.new, @procs)
  end

  def factory(key, factory = nil)
    create(key, factory || Proc.new, @factories)
  end

  def protect(key, service = nil)
    create(key, service || Proc.new)
  end

  def extend(key, extender = nil)
    extender ||= Proc.new
    return set(key, extender) unless extender.is_a?(Proc) && @services.key?(key)

    extended = @services[key]
    call = @factories[key] || @procs[key]
    send(@factories[key] ? :factory : :set, key) do
      extender.call(self, call ? extended.call(self) : extended)
    end
  end

  def each
    @services.each_key { |key| yield key }
    self
  end

  def include?(key)
    @services.key?(key)
  end

  def register
    yield self
    self
  end

  private

  def create(key, service, registry = nil)
    [@procs, @factories].each { |reg| reg.delete key }
    registry[key] = true if registry && service.is_a?(Proc)
    @services[key] = service
    self
  end
end
