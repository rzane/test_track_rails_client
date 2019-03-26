require 'rails_helper'

RSpec.describe TestTrack::Fake::Visitor do
  subject { Class.new(described_class).instance }

  context 'when splits exist' do
    describe '#assignments' do
      it 'returns an array of assignments' do
        expect(subject.assignments).to match_array [
          TestTrack::Fake::Visitor::Assignment.new('buy_one_get_one_promotion_enabled', 'false', false, "the_context"),
          TestTrack::Fake::Visitor::Assignment.new('banner_color', 'blue', false, "the_context")
        ]
      end
    end
  end

  context 'when splits do not exist' do
    before do
      allow(TestTrack::Fake::SplitRegistry.instance).to receive(:to_h).and_return({})
    end

    describe '#assignments' do
      it 'returns an empty array' do
        expect(subject.assignments).to eq []
      end
    end
  end
end
