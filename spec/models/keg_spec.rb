require 'spec_helper'

describe Keg do
  it 'belongs to a beer' do
    subject.should respond_to(:beer)
  end
  it "has a base keg weight through it's beer's brewery"
  describe 'Keg#on_tap' do
    it 'is on tap if tapped and not kicked' do
      a_tapped_keg = Keg.create(:tapped => Date.today)
      Keg.on_tap.should include(a_tapped_keg)
    end
    it 'is not on tap if tapped and kicked' do
      a_finished_keg = Keg.create(:tapped => Date.today, :kicked => Date.today+1)
      Keg.on_tap.should_not include(a_finished_keg)
    end
  end
  describe '#rotate' do
    before do
      @a_new_keg = Keg.create
    end
    it 'taps the new kegs' do
      Keg.rotate(@a_new_keg)
      @a_new_keg.reload.should be_tapped
    end
    it 'populates the tapped date with todays date on the new keg' do
      Keg.rotate(@a_new_keg)
      @a_new_keg.reload.tapped.should == Date.today
    end
    it 'kicks the old keg' do
      old_keg = Keg.create(:tapped => Date.today-1)
      Keg.rotate(@a_new_keg)
      old_keg.reload.should be_kicked
    end
    it 'populates the kicked date with todays date on the old keg' do
      old_keg = Keg.create(:tapped => Date.today-1)
      Keg.rotate(@a_new_keg)
      old_keg.reload.kicked.should == Date.today
    end
    it 'queries via an api the starting weight of the keg on top'
  end
end
