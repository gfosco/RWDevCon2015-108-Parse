//
//  GibGabCell.swift
//  GibGab
//
//  Created by Fosco Marotto on 12/11/14.
//  Copyright (c) 2014 RWDevCon. All rights reserved.
//

class GabCell: UITableViewCell {
  
  @IBOutlet weak var gabText: UILabel!
  @IBOutlet weak var gabVote: UILabel!
  @IBOutlet weak var upButton: UIButton!
  @IBOutlet weak var downButton: UIButton!
  var GabObject : PFObject?
    
  @IBAction func didTapVoteUp(sender: AnyObject) {

    upButton.enabled = false
    downButton.hidden = true
    GabObject?.incrementKey("gabVotes")
    GabObject?.addUniqueObject(PFUser.currentUser().objectId, forKey: "gabVoters")
    gabVote.text = GabObject?.objectForKey("gabVotes").stringValue
    GabObject?.saveEventually()
    
  }
    
  @IBAction func didTapVoteDown(sender: AnyObject) {
   
    downButton.enabled = false
    upButton.hidden = true
    GabObject?.incrementKey("gabVotes", byAmount: -1)
    GabObject?.addUniqueObject(PFUser.currentUser().objectId, forKey: "gabVoters")
    gabVote.text = GabObject?.objectForKey("gabVotes").stringValue
    GabObject?.saveEventually()
    
  }
}
