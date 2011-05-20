require 'spec_helper'

describe Brewery do
  it 'has many beers' do
    subject.should respond_to(:beers)
  end
end
