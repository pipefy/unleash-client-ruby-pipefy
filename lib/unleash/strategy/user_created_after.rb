# frozen_string_literal: true

module Unleash
  module Strategy
    class UserCreatedAfter < Base
      PARAM = 'userCreatedAfter'

      def name
        'userCreatedAfter'
      end

      def is_enabled?(params = {}, context = nil)
        return false unless params.is_a?(Hash) && params.key?(PARAM)
        return false unless params.fetch(PARAM, nil).is_a? String
        return false unless context.instance_of?(Unleash::Context)
        return false if forbidden_org_uuids(params).include?(current_org_uuid(context))

        begin
          base_time = DateTime.parse(params[PARAM]) 
          user_time = DateTime.parse(user_created_at(context))
        rescue ArgumentError
          return false
        end

        user_time >= base_time
      end

      private

      def user_created_at(context)
        context&.properties&.values_at('user_created_at', :user_created_at)&.compact&.first
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
