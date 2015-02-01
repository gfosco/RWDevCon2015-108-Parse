# 108: Intro to Parse, Part 3: Lab

We want users to be able to reply to our Gabs.  The **GabsViewController** is already configured to segue to the **GabRepliesViewController** when a Gab is selected, and it already passes the Parse Object in the **prepareForSegue** method.

Open **NewGabReplyViewController.swift** and update the **didTapSend** method where commented.  Create a Parse Object with a class name of **GabReplies**:

    var reply = PFObject(className: "GabReplies")
    
Set the text of the reply on the object, and assign the Gab itself to the reply:

    reply["replyText"] = replyText.text
    reply["replyUsername"] = PFUser.currentUser().objectForKey("username")
    reply["gabParent"] = GabObject
    
Save the reply object, replacing the 3 lines at the end which stop the activity indicator and pop the view controller:

    reply.saveInBackgroundWithBlock {
      (success: Bool, error: NSError!) -> Void in
      activity.stopAnimating()
      activity.removeFromSuperview()
      self.navigationController?.popViewControllerAnimated(true)
    }

Open **GabRepliesViewController.swift** and lets update the **queryForTable** method.  We will want to view replies for only the Gab we selected in the previous view, so we will constrain the query based on the column **gabParent**.

    query.whereKey("gabParent", equalTo: GabObject)
    
When we created a reply, we saved the Gab replied to in this property.

Unlike the Gabs view, lets display the replies in chronological order:

    query.orderByAscending("createdAt")
    
The default limit for a Parse Query is 100.  We can change this up to a maximum of 1000.

    query.limit = 1000
    
Now, in the **tableView:cellForRowAtIndexPath** method, configure the **GabReplyCell** to display the reply and the username of the person who replied:

    var object = objectAtIndexPath(indexPath)
    cell.replyText.text = object["replyText"] as String!
    cell.replyUsername.text = object["replyUsername"] as String!
    
Now you should be able to add replies to Gabs and see the replies for any Gabs in the system.

Lets use Parse Analytics to track an event when a user submits a Gab entry.  Open **NewGabViewController.swift** and right before the PFObject is created, add:

    PFAnalytics.trackEventInBackground("new-gab", block: nil)
    
In the Parse Analytics dashboard, you'll be able to see the various analytics events you decide to track, and can create & save custom breakdowns.