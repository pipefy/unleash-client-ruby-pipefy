# frozen_string_literal: true

module Unleash
  module Strategy
    class PaidOrg < Base
      def name
        'paidOrg'
      end

      def is_enabled?(_, context = nil)
        paid_org?(context)
      end

      private

      def paid_org?(context)
        context&.properties&.fetch(:paid_org, false)
      end
    end
  end
end
