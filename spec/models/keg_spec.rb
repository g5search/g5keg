require 'spec_helper'

describe Keg do
  it 'belongs to a beer' do
    subject.should respond_to(:beer)
  end

  it 'is invalid without a beer' do
    subject.errors_on(:beer).should_not be_empty
  end

  it 'defaults to a current_weight of 67kg' do
    keg = Factory.create(:keg)
    keg.current_weight.to_i.should eql(67)
  end

  it "has a base keg weight through it's beer's brewery"

  describe 'delegates' do
    it 'name, description, ibus to beer' do
      keg = Factory.build(:keg)
      [:name,:description,:ibus,:alcohol,:logo_path].each do |method|
        keg.send(method).should == keg.beer.send(method)
      end
    end
  end

  describe 'on tap' do
    it 'is on tap if tapped and not kicked' do
      tapped_keg = Factory(:keg, :tapped => Date.today)
      Keg.on_tap.should include(tapped_keg)
    end
    it 'is not on tap if tapped and kicked' do
      kicked_keg = Factory(:keg, :tapped => Date.today, :kicked => Date.today+1)
      Keg.on_tap.should_not include(kicked_keg)
    end
  end

  describe '#current' do
    it 'returns the first on tap keg' do
      @new_keg = Factory(:keg, :tapped => Date.today)
      Keg.current.should == @new_keg
    end
  end

  describe '#rotate' do
    before do
      @new_keg = Factory(:keg)
    end
    it 'taps the new kegs' do
      Keg.rotate(@new_keg)
      @new_keg.reload.should be_tapped
    end
    it 'populates the tapped date with todays date on the new keg' do
      Keg.rotate(@new_keg)
      @new_keg.reload.tapped.should == Date.today
    end
    it 'kicks the old keg' do
      old_keg = Factory(:keg, :tapped => Date.today-1)
      Keg.rotate(@new_keg)
      old_keg.reload.should be_kicked
    end
    it 'populates the kicked date with todays date on the old keg' do
      old_keg = Factory(:keg, :tapped => Date.today-1)
      Keg.rotate(@new_keg)
      old_keg.reload.kicked.should == Date.today
    end
  end

  it "calculates remaining pints from it's current_weight" do
    keg = Factory.build(:keg, :current_weight => 25)
    keg.remaining_pints.should be_within(1).of(31)
  end

  it "calculates remaining percentage from remaining pints" do
    keg = Factory.build(:keg, :current_weight => 40)
    (keg.remaining_percent).should be_within(0.01).of(0.51)
  end
end
