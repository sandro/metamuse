module Metamuse
  module Services
    module Service
      def has_api_key()
        class << self
          attr_reader :api_key

          def api_key=(key)
            @api_key = key
            default_params :api_key => api_key
          end
        end
      end
    end
  end
end
