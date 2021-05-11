# frozen_string_literal: true

module Unleash
  module Strategy
    class OrgWithUUID < Base
      PARAM = 'orgUUIDs'

      def name
        'orgWithUUID'
      end

      def is_enabled?(params = {}, context = nil)
        return false unless params.is_a?(Hash) && params.key?(PARAM)
        return false unless params.fetch(PARAM, nil).is_a? String
        return false unless context.instance_of?(Unleash::Context)

        allowed_org_uuids(params).include?(current_org_uuid(context))
      end

      private

      def current_org_uuid(context)
        context&.properties&.values_at('org_uuid', :org_uuid)&.compact&.first
      end

      def allowed_org_uuids(params)
        params[PARAM].split(',').map(&:strip)
      end
    end
  end
end
