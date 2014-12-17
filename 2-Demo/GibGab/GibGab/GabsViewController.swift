//
//  GibGabTableViewController.swift
//  GibGab
//
//  Created by Fosco Marotto on 12/11/14.
//  Copyright (c) 2014 RWDevCon. All rights reserved.
//

class GabsViewController: PFQueryTableViewController {

  let className : String = "GibGabs"
    
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
    
  override init(style aStyle: UITableViewStyle, className aClassName: String!) {
    super.init(style: aStyle, className: aClassName)
        
    self.parseClassName = className
    self.pullToRefreshEnabled = true
    self.paginationEnabled = false
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(true)
    loadObjects()
  }
    
  override func queryForTable() -> PFQuery! {
    var query = PFQuery(className: className)
    
    query.orderByDescending("updatedAt")
    query.limit = 50
    
    return query;
  }
    
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("GabCell") as GabCell
    var object = objectAtIndexPath(indexPath)
    cell.gabText.text = object["gabText"] as String!
    cell.gabVote.text = object["gabVotes"].stringValue
    cell.GabObject = object
    return cell
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.identifier == "toGabReplies") {
      var destination = segue.destinationViewController as GabRepliesViewController
        destination.GabObject = objectAtIndexPath(tableView.indexPathForSelectedRow())
    }
  }
    
  @IBAction func didTapLogOut(sender: AnyObject) {
    
    // (TODO:CHALLENGE) Use the logOut method of PFUser
    
    dismissViewControllerAnimated(true, completion: nil)
  }
}