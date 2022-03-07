# frozen_string_literal: true

module Unleash
  module Strategy
    class UseCase < Base
      PARAM = 'Experience'

      def name
        'useCase'
      end

      def is_enabled?(params = {}, context = nil)
        return false unless params.is_a?(Hash) && params.key?(PARAM)
        return false unless params.fetch(PARAM, nil).is_a? String
        return false unless context.instance_of?(Unleash::Context)

        use_case_allowed?(params, context)
      end

      private

      def use_case_allowed?(params, context)
        experience = context.properties[:experience]
        return false unless experience

        param = JSON.parse(params[PARAM])
        department = experience[:department]&.strip
        use_case = experience[:use_case]&.strip

        param[department]&.include?(use_case)
      end
    end
  end
end
