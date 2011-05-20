require 'spec_helper'

describe User do
  describe '#create_with_openid' do
    it 'creates new user records' do
      openid_params = {
        "https://axschema.org/contact/email" => [ Factory.sequence(:email) ],
        "http://axschema.org/namePerson/first" => [ 'John' ],
        "http://axschema.org/namePerson/last" => [ 'Doe' ]
      }
      next_id = Factory.sequence(:identity)
      expect {User.create_with_openid(next_id,openid_params)}.to change {User.count}.by(1)
    end
  end

  describe '#full_name' do
    it 'adds a space between first name and last name' do
      user = Factory.build(:user, :first_name => 'John', :last_name => 'Doe')
      user.name.should eql('John Doe')
    end

    it 'removes any leading or trailing space' do
      user = Factory.build(:user, :first_name => 'John', :last_name => '')
      user.name.should eql('John')
    end
  end
end
