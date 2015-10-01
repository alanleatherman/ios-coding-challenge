# 8tracks iOS Coding Challenge

### Requirements
 - Create a new iOS app with Xcode. Use a local git repository so when you submit it we can look at any intermediate commits you may have used.
 - Please use Objective-C. We like Swift, but most of our code is still in Objective-C, so we'd like to see how you work with it.
 - Display a list of playlists ("mixes") in a table view or collection view. You can include whatever basic information you'd like, but at least a mix image should be here.
 - Selecting a mix somehow should display another view with additional information (your choice) about the mix.
 - We're looking for code that we can easily understand, attention to edge cases, and a UI that you are happy with.
 - Have fun with this! We've included a few extra things below so you can experiment if you'd like.
 - When you're happy with it, zip up the folder and send it to us.
 - Is there anything you would do if you had more time? Let us know!

### Reference:
 - You will need to pass your API key with all requests. You can do this by passing `api_key=xyz` as a URL parameter, where `xyz` is the key.
 - If you are building for iOS 9, you may need to configure options for App Transport Security in order to load images returned by our API. See the Apple technote for details: https://developer.apple.com/library/prerelease/ios/technotes/App-Transport-Security-Technote/
 - Endpoint for Staff Picks: `https://8tracks.com/mix_sets/staff-picks.json?api_version=3&include=mixes[user]+pagination`
	 - The best mix image to use is `cropped_imgix_url` in the `cover_urls` part of the response.
	 - If want to try pagination, look at `next_page_path` in the JSON response as a starting point.
