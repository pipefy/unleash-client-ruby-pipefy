# frozen_string_literal: true

module Unleash
  module Strategy
    class PipeWithUUID < Base
      PARAM = 'pipeUUIDs'

      def name
        'pipeWithUUID'
      end

      def is_enabled?(params = {}, context = nil)
        return false unless params.is_a?(Hash) && params.key?(PARAM)
        return false unless params.fetch(PARAM, nil).is_a? String
        return false unless context.instance_of?(Unleash::Context)

        allowed_pipe_uuids(params).include?(current_pipe_uuid(context))
      end

      private

      def current_pipe_uuid(context)
        context&.properties&.values_at('pipe_uuid', :pipe_uuid)&.compact&.first
      end

      def allowed_pipe_uuids(params)
        params[PARAM].split(',').map(&:strip)
      end
    end
  end
end
