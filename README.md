## Twitter [(raw)](https://gist.githubusercontent.com/timothy1ee/b9b1860c8ecb4b0b1c18/raw/2adc3f63677d81644e00245cee891eee88907767/gistfile1.md)

This is a basic twitter app to read and compose tweets the [Twitter API](https://apps.twitter.com/).

Time spent: `11.5`
- 9/12 9:40am-11:40 (sign in with oauth, can make signed request to get user. Video 1: 22:00)
- 9/14 7:45pm-10:15pm (refactored things into TwitterClient)
- 9/14 10:30pm-11:50pm (Get tweets showing up in timeline)
- 9/15 5:00pm-6:40 (Move logout button to navigation controller, time ago on tweets. Autolayout tweet view)
- 9/15 6:40pm-7pm (Pull to refresh)
- 9/15 8pm-9pm (User can compose a new tweet)
- 9/15 9pm-10:20pm (Timeline shows reply, retweet, and favorite icons and correct numbers)
- 9/15 10:20pm-10:45pm (Hooked up retweet and favorite buttons)
- 9/15 10:45pm-10:55pm (Retweeting and favoriting should increment the retweet and favorite count.)
- 9/15 10:55pm-11:55pm (Replies now keep the context of the original tweet. Created gif walkthrough)
- 9/15 submitted v1

### Features, Round 1

#### Required

- [x] User can sign in using OAuth login flow
- [x] User can view last 20 tweets from their home timeline
- [x] The current signed in user will be persisted across restarts
- [x] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.  In other words, design the custom cell with the proper Auto Layout settings.  You will also need to augment the model classes.
- [x] User can pull to refresh
- [x] User can compose a new tweet by tapping on a compose button.
- [s] User can tap on a tweet to view it, with controls to retweet, favorite, and reply. (seems extraneous)
- [x] User can retweet, favorite, and reply to the tweet directly from the timeline feed.

#### Optional

- [ ] When composing, you should have a countdown in the upper right for the tweet limit.
- [ ] After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.
- [x] Retweeting and favoriting should increment the retweet and favorite count.
- [ ] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count.
- [x] Replies should be prefixed with the username and the reply_id should be set when posting the tweet,
- [ ] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.

## Round 2

Time spent: `<Number of hours spent>`

New: 3.75
- 9/20 0.75h 3:00-3:45pm Watch on video hamburgerlers
- 9/20 2.5h 8pm-11:30pm Implementing a not quite fully working hamburger menu.
- 9/20 .5 11:30-12pm Tim helping me debug my hamburger menu.
- 9/21 6:00pm-11:15 Profile view shows your profile and tweets; hamburger menu works.

### Features

#### Required

- [x] Hamburger menu
   - [x] Dragging anywhere in the view should reveal the menu.
   - [x] The menu should include links to your profile, the home timeline, and the mentions view.
   - [x] The menu can look similar to the LinkedIn menu below or feel free to take liberty with the UI. (I took a lot of liberties)
- [x] Profile page
   - [x] Contains the user header view
   - [x] Contains a section with the users basic stats: # tweets, # following, # followers
- [ ] Home Timeline
   - [ ] Tapping on a user image should bring up that user's profile page

#### Optional

- [ ] Profile Page
   - [ ] Optional: Implement the paging view for the user description.
   - [ ] Optional: As the paging view moves, increase the opacity of the background screen. See the actual Twitter app for this effect
   - [ ] Optional: Pulling down the profile page should blur and resize the header image.
   - [x] Show your own tweets on the profile page!
- [ ] Optional: Account switching
   - [ ] Long press on tab bar to bring up Account view with animation
   - [ ] Tap account to switch to
   - [ ] Include a plus button to Add an Account
   - [ ] Swipe to delete an account

### Walkthrough

![Video Walkthrough](https://raw.githubusercontent.com/etucker/tweeker/master/walkthrough.gif)
