# frozen_string_literal: true

require 'unleash/strategy/util'

module Unleash
  module Strategy
    class GradualRolloutOrgUUID < Base
      def name
        'gradualRolloutOrgUUID'
      end

      def is_enabled?(params = {}, context = nil, _constraints = [])
        return false unless params.is_a?(Hash) && params.key?('percentage')
        return false unless context.instance_of?(Unleash::Context)
        return false if forbidden_org_uuids(params).include?(current_org_uuid(context))

        unleash_context = current_org_uuid(context)

        return false if unleash_context.nil? || unleash_context.empty?

        percentage = Integer(params['percentage'] || 0)
        group_id = params.fetch('groupId', '')

        check_enabled_by_percentage(unleash_context, percentage, group_id)
      end

      private

      def current_org_uuid(context)
        context&.properties&.values_at('org_uuid', :org_uuid)&.compact&.first
      end

      def check_enabled_by_percentage(unleash_context, percentage, group_id)
        percentage.positive? && Util.get_normalized_number(unleash_context, group_id) <= percentage
      end

      def forbidden_org_uuids(params)
        params.fetch('disabledOrgUUIDs', '').split(',').map(&:strip)
      end
    end
  end
end
