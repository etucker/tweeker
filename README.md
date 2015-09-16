## Twitter [(raw)](https://gist.githubusercontent.com/timothy1ee/b9b1860c8ecb4b0b1c18/raw/2adc3f63677d81644e00245cee891eee88907767/gistfile1.md)

This is a basic twitter app to read and compose tweets the [Twitter API](https://apps.twitter.com/).

Time spent: `8.5`
- 9/12 9:40am-11:40 (sign in with oauth, can make signed request to get user. Video 1: 22:00)
- 9/14 7:45pm-10:15pm (refactored things into TwitterClient)
- 9/14 10:30pm-11:50pm (Get tweets showing up in timeline)
- 9/15 5:00pm-6:40 (Move logout button to navigation controller, time ago on tweets. Autolayout tweet view)
- 9/15 6:40pm-7pm (Pull to refresh)
- 9/15 8pm-9pm (User can compose a new tweet)
- 9/15 9pm-10:20pm (Timeline shows reply, retweet, and favorite icons and correct numbers)
- 9/15 10:20pm-10:45pm (Hooked up retweet and favorite buttons)
- 9/15 10:45pm-10:55pm (Retweeting and favoriting should increment the retweet and favorite count.)

### Features

#### Required

- [x] User can sign in using OAuth login flow
- [x] User can view last 20 tweets from their home timeline
- [x] The current signed in user will be persisted across restarts
- [x] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.  In other words, design the custom cell with the proper Auto Layout settings.  You will also need to augment the model classes.
- [x] User can pull to refresh
- [x] User can compose a new tweet by tapping on a compose button.
- [ ] User can tap on a tweet to view it, with controls to retweet, favorite, and reply.
- [/] User can retweet, favorite, and reply to the tweet directly from the timeline feed.

#### Optional

- [ ] When composing, you should have a countdown in the upper right for the tweet limit.
- [ ] After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.
- [x] Retweeting and favoriting should increment the retweet and favorite count.
- [ ] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count.
- [ ] Replies should be prefixed with the username and the reply_id should be set when posting the tweet,
- [ ] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.

### Walkthrough

![Video Walkthrough](...)
