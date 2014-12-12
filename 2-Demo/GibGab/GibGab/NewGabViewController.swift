//
//  NewGibGabViewController.swift
//  GibGab
//
//  Created by Fosco Marotto on 12/11/14.
//  Copyright (c) 2014 RWDevCon. All rights reserved.
//

class NewGabViewController: UIViewController, UITextViewDelegate {

  @IBOutlet weak var gabText: UITextView!
    
  override func viewDidAppear(animated: Bool) {
    gabText.becomeFirstResponder()
  }
    
  @IBAction func didTapSend(sender: AnyObject) {
    if (gabText.text.isEmpty) {
      var button = sender as UIButton
      button.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
      return
    }
      
    var activity = UIActivityIndicatorView()
    self.view.addSubview(activity)
    activity.startAnimating()

    var gab = PFObject(className: "GibGabs")
    gab["gabText"] = gabText.text
    gab["gabVotes"] = 0
    gab.saveInBackgroundWithBlock { (success: Bool, error: NSError!) -> Void in
      activity.stopAnimating()
      activity.removeFromSuperview()
      self.navigationController?.popViewControllerAnimated(true)
    }
    
  }
}
