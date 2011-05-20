require 'spec_helper'

describe Keg do
  before do
    @a_brewery = Brewery.create(:name => 'Deschutes')
    @a_beer = Beer.create(:name => 'Meh', 
      :brewery => @a_brewery,
      :description => 'Really hoppy stuff')
  end
  it 'belongs to a beer' do
    subject.should respond_to(:beer)
  end
  it 'is invalid without a beer' do
    subject.errors_on(:beer).should_not be_empty
  end
  it "has a base keg weight through it's beer's brewery"
  describe 'delegates' do
    it 'name, description, ibus to beer' do
      a_keg = Keg.new(:beer => @a_beer)
      [:name,:description,:ibus,:alcohol,:logo_path].each do |method|
        a_keg.send(method).should == @a_beer.send(method)
      end
    end
  end
  describe 'on tap' do
    it 'is on tap if tapped and not kicked' do
      a_tapped_keg = Keg.create(:tapped => Date.today,
        :beer => @a_beer)
      Keg.on_tap.should include(a_tapped_keg)
    end
    it 'is not on tap if tapped and kicked' do
      a_finished_keg = Keg.create(:tapped => Date.today,
        :kicked => Date.today+1,
        :beer => @a_beer)
      Keg.on_tap.should_not include(a_finished_keg)
    end
  end

  describe '#current' do
    it 'returns the first on tap keg' do
      @a_new_keg = Keg.create(:beer => @a_beer, :tapped => Date.today)
      Keg.current.should == @a_new_keg
    end
  end

  describe '#rotate' do
    before do
      @a_new_keg = Keg.create(:beer => @a_beer)
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
      old_keg = Keg.create(:tapped => Date.today-1, :beer => @a_beer)
      Keg.rotate(@a_new_keg)
      old_keg.reload.should be_kicked
    end
    it 'populates the kicked date with todays date on the old keg' do
      old_keg = Keg.create(:tapped => Date.today-1, :beer => @a_beer)
      Keg.rotate(@a_new_keg)
      old_keg.reload.kicked.should == Date.today
    end
    it 'queries via an api the starting weight of the keg on top'
  end
end
