# frozen_string_literal: true

module Unleash
  module Strategy
    class OrgCreatedAfter < Base
      PARAM = 'orgCreatedAfter'

      def name
        'orgCreatedAfter'
      end

      def is_enabled?(params = {}, context = nil)
        return false unless params.is_a?(Hash) && params.key?(PARAM)
        return false unless params.fetch(PARAM, nil).is_a? String
        return false unless context.instance_of?(Unleash::Context)
        return false if forbidden_org_uuids(params).include?(current_org_uuid(context))

        org_creation_date = org_created_at(context)
        return false if org_creation_date.nil?

        begin
          base_time = DateTime.parse(params[PARAM])
          org_time = DateTime.parse(org_creation_date)
        rescue ArgumentError
          return false
        end

        org_time >= base_time
      end

      private

      def org_created_at(context)
        context&.properties&.values_at('org_created_at', :org_created_at)&.compact&.first
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
