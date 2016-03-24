require 'spec_helper'

describe Strudel do
  let(:app) { described_class.new }

  context 'with a static value' do
    let(:array) { [] }
    before { app[:arr] = array }

    it 'should return an exact match' do
      expect(app[:arr]).to equal(array)
    end

    it 'can be extended' do
      app.extend(:arr) { |_a, arr| arr << 'foo' }
      expect(app[:arr]).to eq(['foo'])
    end
  end

  context 'with service proc' do
    before { app.set(:shared) { |_a| {} } }

    it 'should return same object multiple times' do
      expect(app[:shared]).to equal(app[:shared])
    end

    it 'receives the app argument' do
      app.set(:foo) do |a|
        expect(a).to equal(app)
      end
      app[:foo]
    end

    it 'can be extended' do
      app.extend(:shared) do |a, shared|
        expect(a).to equal(app)
        shared[:foo] = 'foo'
        shared
      end
      expect(app[:shared][:foo]).to eq('foo')
      expect(app[:shared]).to equal(app[:shared])
    end

    it 'can be extended by a static' do
      app.extend(:shared, 'foobar')
      expect(app[:shared]).to eq('foobar')
    end
  end

  context 'with factory' do
    before { app.factory(:obj) { |_a| {} } }

    it 'should return different object each call' do
      expect(app[:obj]).not_to equal(app[:obj])
    end

    it 'receives the app argument' do
      app.factory(:foo) do |a|
        expect(a).to equal(app)
      end
      app[:foo]
    end

    it 'can be extended' do
      app.extend(:obj) do |a, obj|
        expect(a).to equal(app)
        obj[:foo] = 'foo'
        obj
      end
      expect(app[:obj][:foo]).to eq('foo')
      expect(app[:obj]).not_to equal(app[:obj])
    end
  end

  context 'with protected proc' do
    let(:proc) { -> {} }
    before { app.protect(:protected, proc) }

    it 'should return the proc' do
      expect(app[:protected]).to equal(proc)
    end

    it 'can be extended' do
      proc2 = nil
      app.extend(:protected) do |a, p|
        expect(a).to equal(app)
        expect(p).to equal(proc)
        proc2 = -> {}
      end
      expect(app[:protected]).to equal(proc2)
    end
  end

  it 'can extend an undefined service' do
    app.extend(:foo) do |_a, p|
      expect(p).to eq(nil)
      'foo'
    end
    expect(app[:foo]).to eq('foo')
  end

  it 'can be chained' do
    app = described_class.new
    app2 = app
           .set(:static, 'foo')
           .factory(:fact, 'fact')
           .protect(:prot, 'prot')
           .extend(:static) {}

    expect(app2).to equal(app)
  end

  it 'is enumerable' do
    app[:foo] = 1
    app.set(:bar) { |_a| 2 }
    app.factory(:baz) { |_a| 3 }
    app.protect(:prot) { 4 }
    expect(app.each).to be_a(Enumerable)
    expect(app.each.to_a).to eq([:foo, :bar, :baz, :prot])
  end

  it 'can check if it includes a key' do
    app[:foo] = 'foo'
    expect(app.include?(:foo)).to eq(true)
    expect(app.include?(:bar)).to eq(false)
  end

  it 'can be initialized with a block' do
    app = described_class.new do |a|
      a[:foo] = 'foo'
    end

    expect(app[:foo]).to eq('foo')
  end
end
