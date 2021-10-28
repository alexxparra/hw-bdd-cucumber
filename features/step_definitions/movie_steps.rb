# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(title: movie["title"], 
        rating: movie["rating"], release_date: movie["release_date"])
  end
end

Then /(.*) seed movies should exist/ do | n_seeds |
  expect(Movie.count).to eq n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
    page.body.index(e1) < page.body.index(e2)
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  str_arr = rating_list.split(", ")
  if uncheck
      str_arr.each { |e|
          uncheck(e)
      }
  else
      str_arr.each { |e|
          check(e)
      }
  end
end

# Part 2, Step 3
Then /^I should (not )?see the following movies: (.*)$/ do |no, movie_list|
  arr = movie_list.split(", ")
  if (no)
      arr.each { |e|
          expect(page).not_to have_content(e)
      }
  else
      arr.each { |e|
          expect(page).to have_content(e)
      }
  end
end

Then /I should see all the movies/ do
    all_movies = Movie.all()
    all_movies.each { |e| 
        expect(page).to have_content(e["title"])
    }
end

### Utility Steps Just for this assignment.

Then /^debug$/ do
  # Use this to write "Then debug" in your scenario to open a console.
   require "byebug"; byebug
  1 # intentionally force debugger context in this method
end

Then /^debug javascript$/ do
  # Use this to write "Then debug" in your scenario to open a JS console
  page.driver.debugger
  1
end


Then /complete the rest of of this scenario/ do
  # This shows you what a basic cucumber scenario looks like.
  # You should leave this block inside movie_steps, but replace
  # the line in your scenarios with the appropriate steps.
  fail "Remove this step from your .feature files"
end
