require 'spec_helper'

describe Ticket do
  pending "add some examples to (or delete) #{__FILE__}"
  context 'instance variables' do
    context '.assigned_name' do
      it 'should return not assigned' do
        ticket = Factory.build(:ticket, :assigned_to => nil)
        ticket.assigned_name.should == 'not assigned'
      end

      it 'should return the user name' do
        user = Factory(:user)
        user.stubs(:name).returns('Dave Thomas')
        ticket = Factory.build(:ticket, :assigned_to => user)
        ticket.assigned_name.should == 'Dave Thomas'
      end
    end

    context '.inactive!' do
      it 'should not be active' do
        ticket = Factory(:ticket)
        ticket.inactive!
        ticket.active.should be_false
      end
    end

    context '.not_new?' do
      it 'should not be new' do
        ticket = Factory(:ticket)
        ticket.stubs(:status).returns('open')
        ticket.not_new?.should be_true
      end
      it 'should be new' do
        ticket = Factory(:ticket)
        ticket.stubs(:status).returns('new')
        ticket.not_new?.should  be_false
      end
    end
  end
end