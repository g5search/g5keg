require 'spec_helper'

describe ApplicationController do
  def sign_in_user
    @user = Factory.create(:user)
    session[:user_id] = @user.id
  end

  it 'returns a User from the session' do
    sign_in_user
    subject.current_user.should == @user
  end

  describe '#signed_in?' do
    it 'is false when no user_id is in the session' do
      subject.should_not be_signed_in
    end

    it 'is true when a current user can be retrieved from the database' do
      sign_in_user
      subject.should be_signed_in
    end
  end

  describe '#require_user' do
    it 'is false unless logged in' do
      subject.stub!(:redirect_to_login).and_return(false)
      subject.require_user.should be_false
    end

    it 'is true when signed in' do
      sign_in_user
      subject.require_user.should be_true
    end
  end

  describe '#redirect_to_login' do
    it 'redirects' do
      get :redirect_to_login
      response.should redirect_to('/admin/login')
    end
  end
end
