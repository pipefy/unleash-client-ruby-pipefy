# frozen_string_literal: true

module Unleash
  module Strategy
    class EmailFromDomain < Base
      def name
        'emailFromDomain'
      end

      def is_enabled?(params = {}, context = nil)
        params['domains'].include? domain(context)
      end

      private

      def domain(context)
        context&.properties&.values_at('email', :email)&.compact&.first&.split('@')&.last
      end
    end
  end
end
