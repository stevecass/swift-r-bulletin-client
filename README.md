##Simple Swift client

A minimal app to demo to students techniques for connecting to a JSON api and using navigation controllers and tableviews.

##Notes

* NSAppTransportSecurity - NSAllowsArbitraryLoads for non-https
* Use of segues
* UITableViewDataSource, UITableViewDelegate 
* willSelectRowAtIndexPath, prepareForSegue, didSelect...
* dispatch_async for updating ui
* NSURLSession#dataTaskWithURL with closure
* UIRefreshControl for pull to update
