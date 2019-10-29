require_relative './../spec_helper'

RSpec.describe 'Scheduler', type: :integration do

  before { allow(File).to receive(:open) }
  let(:scheduler) { Scheduler.new }

  context 'No Error' do
    it 'should schedule a single job' do
      allow(JSON).to receive(:load).and_return({"a" => nil})
      expect(scheduler.tell_order).to eq ['a']
    end

    it 'should schedule non dependent jobs' do
      allow(JSON).to receive(:load).and_return({"a" => nil, "b"=> nil, "c"=> nil})
      expect(scheduler.tell_order).to match_array ['c', 'b', 'a']
    end

    it 'should schedule dependent jobs' do
      allow(JSON).to receive(:load).and_return({"a" => nil, "b"=> "c", "c"=> "f", "d"=>"a", "e"=>"b", "f"=>nil})
      expect(scheduler.tell_order).to match_array ["a", "d", "f", "c", "b", "e"]
    end
  end

  context 'With Error' do
    it 'should respond `itself dependent` error' do
      allow(JSON).to receive(:load).and_return({"a" => "a"})
      expect{ scheduler.tell_order }.to raise_error Errors::ItselfDependent
    end

    it 'should respond `itself dependent` error' do
      allow(JSON).to receive(:load).and_return({"a" => nil, "b"=>"c", "c"=>"f", "d"=>"a", "e"=>nil, "f"=>"b"})
      expect{ scheduler.tell_order }.to raise_error Errors::CircularDependency
    end
  end
end
