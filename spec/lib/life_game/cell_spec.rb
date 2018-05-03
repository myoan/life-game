require_relative '../../spec_helper'

RSpec.describe Cell do
  describe '#alive?' do
    subject { cell.alive? }
    context "when State is DEAD" do
      let(:cell) { Cell.new(0, 0, false) }
      it { is_expected.to be false }
    end

    context "when State is ALIVE" do
      let(:cell) { Cell.new(0, 0, true) }
      it { is_expected.to be true }
    end
  end
end
