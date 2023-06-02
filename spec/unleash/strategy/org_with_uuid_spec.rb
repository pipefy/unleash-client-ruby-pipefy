# frozen_string_literal: true

require 'unleash/context'
require 'unleash/strategy/org_with_uuid'

RSpec.describe Unleash::Strategy::OrgWithUUID do
  describe '#is_enabled?' do
    let(:strategy) { Unleash::Strategy::OrgWithUUID.new }
    let(:unleash_context) { Unleash::Context.new({ properties: { 'org_uuid' => '1234' } }) }

    it 'should be enabled with correct params/context as str' do
      expect(strategy.is_enabled?({ 'orgUUIDs' => '1234,2567,1564' }, unleash_context)).to be_truthy
    end

    it 'should be enabled with correct params/context as sym' do
      unleash_context2 = Unleash::Context.new({ properties: { org_uuid: '2567' } })
      expect(strategy.is_enabled?({ 'orgUUIDs' => '1234,2567,1564' }, unleash_context2)).to be_truthy
    end

    it 'should not be enabled with wrong params/context' do
      unleash_context2 = Unleash::Context.new({ properties: { 'org_uuid' => '666' } })
      expect(strategy.is_enabled?({ 'orgUUIDs' => '1234,2567,1564' }, unleash_context2)).to be_falsey
    end
  end
end
