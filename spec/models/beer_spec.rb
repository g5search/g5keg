require 'spec_helper'

describe Beer do
  it 'should belong to a brewery' do
    subject.should respond_to :brewery
  end

  it 'should have many kegs' do
    subject.should respond_to :kegs
  end

  it 'should be rateable' do
    subject.should respond_to :rate_it
  end

  describe 'validations' do
    it 'should not be valid without a name' do
      subject.errors_on(:name).should_not be_empty
    end
    it 'should not be valid without a brewery' do
      subject.errors_on(:brewery).should_not be_empty
    end
  end
end
