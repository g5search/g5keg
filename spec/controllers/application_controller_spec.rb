require 'spec_helper'

describe ApplicationController do
  it 'returns a User from the session' do
    user = Factory.create(:user)
    session[:user_id] = user.id
    subject.current_user.should == user
  end

  describe '#signed_in?' do
    it 'is false when no user_id is in the session' do
      subject.should_not be_signed_in
    end

    it 'is true when a current user can be retrieved from the database' do
      user = Factory.create(:user)
      session[:user_id] = user.id
      subject.should be_signed_in
    end
  end
end
