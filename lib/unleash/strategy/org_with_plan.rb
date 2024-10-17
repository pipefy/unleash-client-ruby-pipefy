# frozen_string_literal: true

module Unleash
  module Strategy
    class OrgWithPlan < Base
      PARAM = 'orgPlans'

      def name
        'orgWithPlan'
      end

      def is_enabled?(params = {}, context = nil)
        allowed_plans(params).include?(current_org_plan(context))
      end

      private

      def current_org_plan(context)
        context&.properties&.fetch(:org_plan, nil)
      end

      def allowed_plans(params)
        params[PARAM].split(',').map(&:strip)
      end
    end
  end
end
