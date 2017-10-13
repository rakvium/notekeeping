require 'rails_helper'

RSpec.describe "notes/new", type: :view do
  before(:each) do
    @note = assign(:note, FactoryGirl.create(:note, text: 'MyText'))
  end

  xit "renders new note form" do
    render

    assert_select "form[action=?][method=?]", notes_path, "post" do

      assert_select "textarea[name=?]", "note[text]"

    end
  end
end
