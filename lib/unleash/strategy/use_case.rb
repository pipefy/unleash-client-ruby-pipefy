# frozen_string_literal: true

module Unleash
  module Strategy
    class UseCase < Base
      PARAM = 'Experience'

      def name
        'useCases'
      end

      def enabled?(params = {}, context = nil)
        return false unless params.is_a?(Hash) && params.key?(PARAM)
        return false unless params.fetch(PARAM, nil).is_a? String
        return false unless context.instance_of?(Unleash::Context)

        use_cases_allowed?(params, context)
      end

      private

      def use_cases_allowed?(params, context)
        experience = JSON.parse(params[PARAM])
        department = context.properties[:department].strip
        use_case = context.properties[:use_case].strip

        experience[department].include?(use_case)
      end
    end
  end
end
