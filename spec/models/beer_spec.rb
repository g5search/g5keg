require 'spec_helper'

describe Beer do
  before do
    @beer = Beer.new(:name => 'Musk Ox')
  end

  after do
    @beer.destroy unless @beer.new_record?
  end

  it 'should belong to a brewery' do
    @beer.should respond_to :brewery
  end

  it 'should return beers on tap' do
    Beer.should respond_to :on_tap
  end

  it 'should return the beer currently on tap' do
    @beer.on_tap = true
    @beer.save
    Beer.currently_on_tap.should == @beer
  end

  it 'should inform you if the keg is untapped' do
    Beer.update_all(:on_tap => false)
    Beer.should_not be_currently_tapped
  end

  context 'tapping' do
    before do
      @beer.tap
    end

    it 'should tap a beer' do
      Beer.currently_on_tap.should == @beer
    end

    it 'should only tap a beer if the keg is untapped' do
      some_other_beer = Beer.new(:name => 'Different Beer')
      some_other_beer.try :tap
      some_other_beer.errors[:on_tap].should_not be_nil
      Beer.on_tap.should have_at_most(1).things
    end

    it 'should untap a beer' do
      @beer.un_tap
      Beer.currently_on_tap.should be_nil
    end

    it 'should rotate the keg with a current beer' do
      new_beer = Beer.create(:name => 'Musk Ox Deux')
      Beer.rotate_keg(new_beer)
      Beer.currently_on_tap.should == new_beer
    end
  end
end
