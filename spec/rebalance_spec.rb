# frozen_string_literal: true

require 'pry'
require_relative '../rebalance'

RSpec.describe Rebalance do
  let(:current_portfolio) { { WMT: 250, TSLA: 550 } }
  let(:desired_portfolio) { { WMT: 400, TSLA: 400 } }

  subject { described_class.new(current_portfolio: current_portfolio, desired_portfolio: desired_portfolio) }

  context '#initialize' do
    it 'sets the current_portfolio and desired_portfolio instance variables' do
      expect(subject.current_portfolio).to eq(current_portfolio)
      expect(subject.desired_portfolio).to eq(desired_portfolio)
    end
  end

  context '#calculate' do
    it 'rebalances the current portfolio' do
      expect(subject.calculate).to eq([{ FROM: :TSLA, TO: :WMT, AMOUNT: 150 }])
    end

    context 'when current_portfolion is balanced' do
      let(:current_portfolio) { { WMT: 200, TSLA: 200 } }
      let(:desired_portfolio) { { WMT: 200, TSLA: 200 } }

      it 'returns no trade needed output' do
        expect(subject.calculate).to eq('No trade needed')
      end
    end

    context 'when desired portfolio has new stocks' do
      let(:current_portfolio) { { WMT: 10, TSLA: 10 } }
      let(:desired_portfolio) { { WMT: 8, TSLA: 8, MSFT: 4 } }

      it 'reuturns the instructions to achieveing the desired portfolio' do
        expect(subject.calculate).to eq([{:FROM=>:WMT, :TO=>:MSFT, :AMOUNT=>2}, {:FROM=>:TSLA, :TO=>:MSFT, :AMOUNT=>2}])
      end
    end

    context 'decimal handling' do
      let(:current_portfolio) { { WMT: 3.2, TSLA: 2.1 } }
      let(:desired_portfolio) { { WMT: 5, TSLA: 0.3 } }

      it 'reuturns the instructions to achieveing the desired portfolio' do
        expect(subject.calculate).to eq([{ FROM: :TSLA, TO: :WMT, AMOUNT: 1.8 }])
      end
    end
  end
end