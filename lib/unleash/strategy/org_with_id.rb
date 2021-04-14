require "unleash/strategy/base"

module Unleash
  module Strategy
    class OrgWithId < Base
      VERSION = '1.0'.freeze
      PARAM = 'orgIds'.freeze

      def name
        'orgWithId'
      end

      def is_enabled?(params = {}, context = nil)
        return false unless params.is_a?(Hash) && params.key?(PARAM)
        return false unless params.fetch(PARAM, nil).is_a? String
        return false unless context.instance_of?(Unleash::Context)

        org_id_from_context = context&.properties&.values_at('org_id', :org_id).compact.first
        params[PARAM].split(',').map(&:strip).include?(org_id_from_context)
      end
    end
  end
end
