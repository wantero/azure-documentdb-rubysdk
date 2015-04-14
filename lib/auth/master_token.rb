require 'uri'
require_relative 'hmac_encoder'

module Azure
  class MasterToken
    def initialize verb, resource_type, resource_id, master_key
      self.verb = verb
      self.resource_id = resource_id
      self.resource_type = resource_type
      self.master_key = master_key
    end

    def generate rfc7321_date
      type = "master"
      token_version = "1.0"
      text = "#{verb}\n#{resource_type}\n#{resource_id}\n#{rfc7321_date}\n\n"
      signature = Azure::HMACEncoder.new.encode master_key, text
      URI.escape "type=#{type}&ver=#{token_version}&sig=#{signature}"
    end

    private
    attr_accessor :verb, :resource_id, :resource_type, :master_key
  end
end
