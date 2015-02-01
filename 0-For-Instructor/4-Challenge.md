# 108: Intro to Parse, Part 4: Challenge

The **GabsViewController** has a Log Out button as its top left bar button item.  Update the **didTapLogOut** method to use the **logOut** method of **PFUser** and dismiss the current view controller.  

Now that we’ve logged out, we need to be able to log back in to our account.
Much like the **PFSignUpViewController**, ParseUI offers a **PFLogInViewController**, it works just like the signup controller.
* Update the **ViewController** class to specify it will be a delegate for **PFLogInViewController*** Add the delegate method for a **logInViewController:didLogInUser** which does the same that the signup delegate did.
We also want users to be able to down-vote a Gab.  Update **GabCell.swift** to use the **didTapVoteDown** method to reduce the vote count of the Gab by one, just like the **didTapViewUp** method incremented it.  Hint: You can increment the field by a negative number.

In the Lab, we added a custom Parse Analytics event when a Gab is submitted.  Add another custom event that occurs when a user replies to a Gab.

Now the app, while basic, is complete.  Users can sign up, log in, share Gabs, vote on Gabs, and reply to Gabs.  This app barely scratches the surface of Parse and what it can do, and over-simplifies for the point of brevity and speed.  It is recommended to, during development, secure objects further using Access Control Lists, and moving certain functionality to our powerful Cloud Code functionality.  Adding Push Notifications would allow you to notify users when others vote on or reply to their Gabs.  GeoLocation could be added to Gabs, and our Geo-spatial queries can retrieve Gabs that are nearby.  Image uploads, user profiles, increased analytics… There are many great and time-saving features you can access with Parse.