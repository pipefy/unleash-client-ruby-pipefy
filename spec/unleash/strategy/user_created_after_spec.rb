# frozen_string_literal: true

require 'unleash/context'

RSpec.describe Unleash::Strategy::UserCreatedAfter do
  describe '#is_enabled?' do
    let(:strategy) { Unleash::Strategy::UserCreatedAfter.new }
    let(:unleash_context) { Unleash::Context.new({ properties: { org_uuid: '1234', 'user_created_at' => '2021-05-27 17:50:59 UTC' } }) }

    it 'should be enabled if user creation date is older then strategy set date' do
      expect(strategy.is_enabled?({ 'userCreatedAfter' => '2021-01-01 00:00:00 UTC' }, unleash_context)).to be_truthy
    end

    it 'should be disabled if user creation date is prior to strategy set date' do
      expect(strategy.is_enabled?({ 'userCreatedAfter' => '2022-01-01 00:00:00 UTC' }, unleash_context)).to be_falsey
    end

    it 'should be disabled if strategy date format is not parsable to DateTime' do
      expect(strategy.is_enabled?({ 'userCreatedAfter' => 'xxx' }, unleash_context)).to be_falsey
    end

    it 'should always disabled for orgUUIDs listed on the disabledOrgUUIDs' do
      params = {
        'userCreatedAfter' => '2021-01-01 00:00:00 UTC',
        'disabledOrgUUIDs' => '1234, 1256, 1267, 1289'
      }

      expect(strategy.is_enabled?(params, unleash_context)).to be_falsey
    end

    it 'should always enabled for orgUUIDs listed on the enabledOrgUUIDs' do
      params = {
        'userCreatedAfter' => '2022-01-01 00:00:00 UTC',
        'enabledOrgUUIDs' => '1234, 1256, 1267, 1289'
      }

      expect(strategy.is_enabled?(params, unleash_context)).to be_truthy
    end
  end
end
