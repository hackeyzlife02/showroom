require 'spec_helper'

describe "FriendlyForwardings" do
  it "should forward to the requested page after signin" do
    employee = Factory(:employee)
    visit edit_employee_path(employee)
    # The test automatically follows the redirect to the signin page.
    fill_in :email,    :with => employee.email
    fill_in :password, :with => employee.password
    click_button
    # The test follows the redirect again, this time to employees/edit.
    response.should render_template('employees/edit')
  end
end
