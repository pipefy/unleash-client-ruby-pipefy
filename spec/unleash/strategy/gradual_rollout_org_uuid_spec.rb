# frozen_string_literal: true

require 'spec_helper'
require 'unleash/context'
require 'unleash/strategy/gradual_rollout_org_uuid'

RSpec.describe Unleash::Strategy::GradualRolloutOrgUUID do
  describe '#is_enabled?' do
    let(:strategy) { Unleash::Strategy::GradualRolloutOrgUUID.new }
    let(:unleash_context) { Unleash::Context.new({ properties: { 'org_uuid' => '1234' } }) }
    let(:percentage) { Unleash::Strategy::Util.get_normalized_number(unleash_context&.properties&.values_at('org_uuid', :org_uuid)&.compact&.first, '') }

    it 'return true when percentage set is gt the number returned by the hash function' do
      expect(strategy.is_enabled?({ 'percentage' => (percentage + 1).to_s }, unleash_context)).to be_truthy
      expect(strategy.is_enabled?({ 'percentage' => percentage + 1 },   unleash_context)).to be_truthy
      expect(strategy.is_enabled?({ 'percentage' => percentage + 0.1 }, unleash_context)).to be_truthy
    end

    it 'return false when percentage set is lt the number returned by the hash function' do
      expect(strategy.is_enabled?({ 'percentage' => (percentage - 1).to_s }, unleash_context)).to be_falsey
      expect(strategy.is_enabled?({ 'percentage' => percentage - 1 },   unleash_context)).to be_falsey
      expect(strategy.is_enabled?({ 'percentage' => percentage - 0.1 }, unleash_context)).to be_falsey
    end

    it 'should always be disabled for orgUUIDs listed on the disabledOrgUUIDs' do
      params = {
        'percentage' => 100,
        'disabledOrgUUIDs' => '1234, 1256, 1267, 1289'
      }
      unleash_context2 = Unleash::Context.new({ properties: { org_uuid: '1234' } })
      expect(strategy.is_enabled?(params, unleash_context2)).to be_falsey

      unleash_context3 = Unleash::Context.new({ properties: { org_uuid: '2567' } })
      expect(strategy.is_enabled?(params, unleash_context3)).to be_truthy
    end
  end
end
