module Support
  module Integration
    def sign_in(person)
      visit root_url(host: "test.host")
      fill_in("Name", with: person.name)
      fill_in("Email", with: person.email)
      fill_in("Nickname", with: person.github_nickname)
      click_button "Sign In"
      page.body.must_include("Welcome to Liskov")
    end
  end
end