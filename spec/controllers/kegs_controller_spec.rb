require 'spec_helper'

describe KegsController do
  describe '#rotate' do
    before do
      @request.env['HTTP_REFERER'] = '/admin'
      @old_keg = Factory.create(:keg)
      @params = { :keg => { :beer_id => @old_keg.beer.id } }
    end
    it 'creates a new keg' do
      expect {post :rotate, @params}.to change {Keg.count}.by(1)
    end
    it 'rotates the new keg in' do
      @a_new_keg = Factory.create(:keg)
      Keg.stub(:create).and_return(@a_new_keg)
      post :rotate, @params
      Keg.current.should == @a_new_keg
    end
    it 'flashes success' do
      post :rotate, @params
      flash[:notice].should_not be_empty
    end
    it 'redirects back' do
      post :rotate, @params
      response.should be_redirect
    end
  end
end
