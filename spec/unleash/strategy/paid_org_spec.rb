# frozen_string_literal: true

require 'unleash/context'
require 'unleash/strategy/paid_org'

RSpec.describe Unleash::Strategy::PaidOrg do
  describe '#is_enabled?' do
    let(:strategy) { Unleash::Strategy::PaidOrg.new }
    let(:unleash_context) { Unleash::Context.new({ properties: paid_org_property }) }
    let(:paid_org_property) { { 'paid_org' => 'true' } }

    context 'with correct context as str' do
      it 'should be enabled' do
        expect(strategy.is_enabled?(nil, unleash_context)).to be_truthy
      end
    end

    context 'with correct context as sym' do
      let(:paid_org_property) { { paid_org: 'true' } }
  
      it 'should be enabled' do
        expect(strategy.is_enabled?(nil, unleash_context)).to be_truthy
      end
    end

    context 'with wrong/falsey context' do
      let(:paid_org_property) { { 'paid_org' => false } }
  
      it 'should not be enabled' do
        expect(strategy.is_enabled?(nil, unleash_context)).to be_falsey
      end
    end
  end
end
