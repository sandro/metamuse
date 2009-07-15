module FakeObject
  def fake(*args)
    Fake.new *args
  end

  class Fake
    attr_reader :name, :strategy, :expectations

    def initialize(*args)
      @strategy = extract_strategy(args.last) || :stub
      setup args
    end

    def setup(args)
      case arg = args.shift
      when Hash
        set_expectations arg
      when String
        @name = arg
        setup args
      when NilClass
      else
        raise ArgumentError, "Hash excepted, got: #{args.inspect}"
      end
    end

    def set_expectations(expectations)
      expectations.each do |method_name, return_value|
        ::RR.send(strategy, self).__send__(method_name).returns(return_value) # stub(object).method.returns(value)
      end
    end

    def extract_strategy(arg)
      arg[:strategy] if Hash === arg
    end
  end
end

