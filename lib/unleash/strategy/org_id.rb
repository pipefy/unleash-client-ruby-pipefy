require "unleash/strategy/base"

module Unleash
  module Strategy
    class OrgId < Base
      VERSION = '0.1.0'.freeze
      PARAM = 'orgIds'.freeze

      def name
        'org_id'
      end

      # need: params['companyIds'], context.properties['companyId'],
      def is_enabled?(params = {}, context = nil)
        return false unless params.is_a?(Hash) && params.has_key?(PARAM)
        return false unless params.fetch(PARAM, nil).is_a? String
        return false unless context.class.name == 'Unleash::Context'

        # Custom strategy code goes here...
        org_id_from_context = context&.properties&.values_at('org_id', :org_id).compact.first
        params[PARAM].split(",").map(&:strip).include?(org_id_from_context)
      end
    end
  end
end
