##Simple Swift client

A minimal app to demo to students techniques for connecting to a JSON api and using navigation controllers and tableviews.

##Notes

* NSAppTransportSecurity - NSAllowsArbitraryLoads for non-https
* Use of segues
* UITableViewDataSource, UITableViewDelegate
* willSelectRowAtIndexPath, prepareForSegue, didSelect...
* Using dispatch_async(dispatch_get_main_queue(), {}) from background tasks for UI updates
* NSURLSession#dataTaskWithURL with closure
* NSURLSession#dataTaskWithRequest
* UIRefreshControl for pull to update
* Presenting a view from nib rather than storyboard
* Presenting a modal view
* Using NSMutableURLRequest for method, headers etc
