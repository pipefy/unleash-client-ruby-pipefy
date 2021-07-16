# frozen_string_literal: true

module Unleash
  module Strategy
    class EmailFromDomain < Base
      PARAM = 'domains'.freeze

      def name
        'emailFromDomain'
      end

      def is_enabled?(params = {}, context = nil)
        return false unless params.is_a?(Hash) && params.has_key?(PARAM)
        return false unless params.fetch(PARAM, nil).is_a? String
        return false unless context.class.name == 'Unleash::Context'

        params[PARAM].split(",").map(&:strip).include? domain(context)
      end

      private

      def domain(context)
        context&.properties&.values_at('email', :email)&.compact&.first&.split('@')&.last
      end
    end
  end
end
