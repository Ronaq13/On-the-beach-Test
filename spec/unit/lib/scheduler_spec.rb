require_relative './../../spec_helper'

RSpec.describe 'Scheduler', type: :unit do
  it 'takes input from file ./input.json by default' do
    expect(File).to receive(:open).with('./input.json')
    Scheduler.new
  end

  context 'Stub input file' do
    before { allow(File).to receive(:open) }

    it 'will make a graph from the the jobs' do
      allow(JSON).to receive(:load).and_return({a: nil, b: 'c', c: nil})
      scheduler = Scheduler.new
      scheduler.send(:make_graph)
      expect(scheduler.graph.to_a).to eq ['root', :a, :b, 'c', :c]
    end

    it 'can add dependency of a job on other' do
      allow(JSON).to receive(:load).and_return(
        {
          "a" => nil,
          "b" => "c",
          "c" => nil,
          "d" => "a"
        }
      )
      scheduler = Scheduler.new
      # 'c' should be before 'b' and 'a' should be before 'd'
      expect(scheduler.tell_order).to eq ['c', 'b', 'a', 'd']
    end
  end
end
