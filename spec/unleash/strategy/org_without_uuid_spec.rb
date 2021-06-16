# frozen_string_literal: true

require 'unleash/context'

RSpec.describe Unleash::Strategy::OrgWithoutUUID do
  describe '#is_enabled?' do
    let(:strategy) { Unleash::Strategy::OrgWithoutUUID.new }
    let(:unleash_context) { Unleash::Context.new({ properties: { 'org_uuid' => '1234' } }) }

    it 'should not be enabled with correct params/context as str' do
      expect(strategy.is_enabled?({ 'disabledOrgUUIDs' => '1234' }, unleash_context)).to be_falsey
    end

    it 'should not be enabled with correct params/context as sym' do
      unleash_context2 = Unleash::Context.new({ properties: { org_uuid: '2567' } })
      expect(strategy.is_enabled?({ 'disabledOrgUUIDs' => '1234,2567,1564' }, unleash_context2)).to be_falsey
    end

    it 'should be enabled if the org is not in the params/context' do
      unleash_context3 = Unleash::Context.new({ properties: { 'org_uuid' => '666' } })
      expect(strategy.is_enabled?({ 'disabledOrgUUIDs' => '1234,2567,1564' }, unleash_context3)).to be_truthy
    end
  end
end
