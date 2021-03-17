require 'test_helper'

class AdminTest < ActiveSupport::TestCase
  test 'should create admin' do
    admin = build :admin
    admin.save

    created_admin = Admin.last
    assert created_admin
  end

  test 'should not create admin without email' do
    admin = build :admin, email: nil
    admin.save

    created_admin = Admin.last
    assert_nil created_admin
  end

  test 'email should be unique' do
    first_admin = build :admin, email: 'test@gmail.com'
    first_admin.save
    second_admin = build :admin, email: 'test@gmail.com'
    assert_not second_admin.save
  end

  test 'should not create incorrect role' do
    admin = build :admin, role: 'some_test_role'
    assert admin.invalid?
  end

  test 'should deleted admin' do
    admin = create :admin
    admin.del
    assert_equal 'deleted', admin.state
  end

  test 'should not create surname' do
    admin = build :admin, surname: 'surname1'
    assert admin.invalid?
  end

  test 'should not create patronymic' do
    admin = build :admin, patronymic: 'patronymic1'
    assert admin.invalid?
  end
end
