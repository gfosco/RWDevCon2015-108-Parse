# 108: Intro to Parse, Part 2: Demo

Each step of this tutorial builds upon the completed version of the previous step.  The starter project has Parse installed, a Storyboard designed, and most of the needed functions are stubbed out.First we’re going to show the Storyboard and walk through each screen of the app.
When the app first loads, **ViewController** will be the first view controller to appear.  In its **viewDidAppear** method, it will check to see if a Parse User is currently logged in.  If there is a user present, it will perform a segue defined in the storyboard named **goToMain** which transitions to the **GabsViewController**.  On it are two buttons, one to log in, one to sign up.  We’re going to add the Sign Up functionality, using the very handy **PFSignUpViewController**, provided by the **ParseUI** framework. 
Open up **ViewController.swift** and update the class definition to declare it as a delegate:

    class ViewController: UIViewController, PFSignUpViewControllerDelegate {
    
Now update the **didTapSignUp** method:

    @IBAction func didTapSignUp(sender: AnyObject) {      var signupController = PFSignUpViewController()      signupController.fields = PFSignUpFields.UsernameAndPassword        | PFSignUpFields.SignUpButton        | PFSignUpFields.DismissButton      signupController.delegate = self          presentViewController(signupController, animated: true,    completion: nil)    }

Next we need to add a method, which as the delegate for the **PFSignUpViewController** will be called when a sign up succeeds:

    // Successful signup:
    func signUpViewController(signUpController: PFSignUpViewController!, didSignUpUser user: PFUser!) {
      signUpController.dismissViewControllerAnimated(true, completion: nil)
      performSegueWithIdentifier("goToMain", sender: self)
    }

In this case, we'll just perform a segue to the **GabsViewController** which is already defined in the storyboard.

We can run the app now, and verify that the sign up controller works.  After testing the failure cases, we’ll actually complete a valid signup, and we’ll wind up at the **GabsViewController**.  Just a few lines of code, and we can register and save users on Parse.
**GabsViewController** will display data from Parse, but before there’s anything to display, lets add some data.  **GabsViewController** has a “New” button at the top right of the navigation bar.  It segues to the **NewGabViewController**.  This screen has a single text field.  Open **NewGabViewController** and update the **didTapSend** method where the comment is:

    var gab = PFObject(className: "Gabs")    gab["gabText"] = gabText.text    gab["gabVotes"] = 0    gab["gabVoters"] = []    gab.saveInBackgroundWithBlock { 		(success: Bool, error: NSError!) -> Void in      activity.stopAnimating()      activity.removeFromSuperview()      self.navigationController?.popViewControllerAnimated(true)    }

Just a few lines of code, and this will store the “Gab” on Parse.  Now let’s get back to the **GabsViewController** to display what we’ve saved.
**GabsViewController** is using another ParseUI feature, the **PFQueryTableViewController**.  It makes it really easy to manage a table of results from a Parse Query.
Open **GabsViewController.swift** and in the **queryForTable** method, and replace the “invalid” constraint with an ordering constraint and a limit:

    query.orderByDescending("createdAt")
    query.limit = 50
    
We'll get at most 50 results, and the newest records will be first.  Update the **tableView:cellForRowAtIndexPath** method to configure the cell with the values from the Gab object:

    var object = objectAtIndexPath(indexPath)
    cell.gabText.text = object["gabText"] as String!
    cell.gabVote.text = object["gabVotes"] .stringValue
    cell.GabObject = object
    
We can run the application, create a Gab, and see it displayed in the table along with its vote count.  Each **GabCell** has up and down arrows, for voting on a Gab.  Open up **GabCell.swift** and update the **didTapVoteUp** method:

    upButton.hidden = true
    downButton.hidden = true
    GabObject?.incrementKey("gabVotes", byAmount: 1)
    GabObject?.addUniqueObject(
      PFUser.currentUser().objectId, forKey: "gabVoters"
    )
    gabVote.text = GabObject?.objectForKey("gabVotes").stringValue
    GabObject?.saveEventually(nil)

This will perform an increment operation on the **gabVotes** column, and add the current users “id” to an array field named **gabVoters**.
We also need to go update **GabsViewController**, to check the **gabVoters** key, to prevent the user from voting again after refreshing the table or reloading the app.

    var voters = object["gabVoters"] as Array<String>
    for voter in voters {
      if (voter == PFUser.currentUser().objectId) {
        cell.upButton.hidden = true
        cell.downButton.hidden = true
      }
    }

At this point, we have a social app with user sign-up, content submission, and upvoting.  In the lab, we’ll add replies, and in the challenge, you’ll add user login and downvoting.