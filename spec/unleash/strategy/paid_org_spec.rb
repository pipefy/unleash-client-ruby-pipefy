# frozen_string_literal: true

require 'unleash/context'
require 'unleash/strategy/org_with_plan'

RSpec.describe Unleash::Strategy::OrgWithPlan do
  describe '#is_enabled?' do
    let(:strategy) { Unleash::Strategy::OrgWithPlan.new }
    let(:unleash_context) { Unleash::Context.new({ properties: org_plan_property }) }
    let(:params) { { 'orgPlans' => "Pro,Enterprise" } }
    let(:org_plan_property) { { 'org_plan' => 'Pro' } }

    context 'with correct context as str' do
      it 'should be enabled' do
        expect(strategy.is_enabled?(params, unleash_context)).to be_truthy
      end
    end

    context 'with correct context as sym' do
      let(:org_plan_property) { { 'org_plan' => 'Pro' } }
  
      it 'should be enabled' do
        expect(strategy.is_enabled?(params, unleash_context)).to be_truthy
      end
    end

    context 'with wrong/falsey context' do
      let(:org_plan_property) { { 'org_plan' => 'Free' } }
  
      it 'should not be enabled' do
        expect(strategy.is_enabled?(params, unleash_context)).to be_falsey
      end
    end
  end
end
