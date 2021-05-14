# frozen_string_literal: true

require 'unleash/strategy/util'

module Unleash
  module Strategy
    class FlexibleRolloutOrgUUID < Base
      def name
        'flexibleRolloutOrgUUID'
      end

      def is_enabled?(params = {}, context = nil)
        return false unless params.is_a?(Hash)
        return false unless context.instance_of?(Unleash::Context)
        return false if forbidden_org_uuids(params).include?(current_org_uuid(context))

        stickiness = params.fetch('stickiness', 'default')
        stickiness_id = resolve_stickiness(stickiness, context)

        begin
          percentage = Integer(params.fetch('rollout', 0))
          percentage = 0 if percentage > 100 || percentage.negative?
        rescue ArgumentError
          return false
        end

        group_id = params.fetch('groupId', '')
        normalized_number = Util.get_normalized_number(stickiness_id, group_id)

        return false if stickiness_id.nil?

        (percentage.positive? && normalized_number <= percentage)
      end

      private

      def random
        Random.rand(0..100)
      end

      def resolve_stickiness(stickiness, context)
        case stickiness
        when 'orgUUID'
          current_org_uuid(context)
        when 'sessionId'
          context.session_id
        when 'random'
          random
        when 'default'
          current_org_uuid(context) || context.session_id || random
        else
          nil
        end
      end

      def current_org_uuid(context)
        context&.properties&.values_at('org_uuid', :org_uuid)&.compact&.first
      end

      def forbidden_org_uuids(params)
        params.fetch('disabledOrgUUIDs', '').split(',').map(&:strip)
      end
    end
  end
end
