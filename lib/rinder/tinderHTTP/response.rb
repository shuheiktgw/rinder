

class Response
  attr_reader :faraday_response

  def self.initialize_recommendations(res)
    # self.new?
    instance = self.class.new(res)
    recs = Array(res[:results]).map { |r| Profile.new(r) }

    instance.instance_variable_set(:recommendations, recs)
    def instance.recommendations
      @recommendations
    end

  end

  def initialize(res)
    @faraday_response = res
  end

  def method_missing(method, *args)
    if method_name.to_s =~ /factory_(\w*)/
      instance_variable_set('@' + $1, args[0])
      self.class.send(:attr_reader, $1.to_sym)
    else
      faraday_response.send(method, *args)
    end
  end

  def respond_to_missing?(method, include_private = false)
    faraday_response.respond_to?(method)
  end
end
