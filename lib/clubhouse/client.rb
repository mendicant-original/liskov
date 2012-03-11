require 'open-uri'

module Clubhouse
  module Client
    class << self
      attr_accessor :service_url, :test_mode

      def get(path)
        if test_mode
          url = Rails.root.join("test/fixtures/clubhouse/#{path}.json")
        else
          url = "#{service_url}/#{path}.json"
        end

        OpenStruct.new(JSON.parse(open(url).read))
      rescue Errno::ENOENT
        # User file not found when in test mode
        return nil
      end
    end
  end
end