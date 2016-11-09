//
//  HomeController.swift
//  JCChat
//
//  Created by Jamar Brooks on 11/5/16.
//  Copyright © 2016 Grace Lam. All rights reserved.
//

import UIKit
import QuartzCore
import FirebaseAuth
import FirebaseDatabase

class HomeController: UIViewController {

    @IBOutlet var likeScrollView : UIScrollView!
    
    @IBOutlet var exploreScrollView : UIScrollView!
    
    @IBOutlet var exploreView : UIView!
    
    @IBOutlet var likeView : UIView!
    
    @IBOutlet var searchBar : UITextField!
    
    var searchText : String = ""
    
    var topics = ["Depression", "Breakups", "Encouragement", "Family", "Divorce", "Abuse",
        "Loneliness",
        "Pride",
        "Jealousy", "Confidence", "Time Management", "Balance", "Friendships", "Doubts", "Love", "Stress", "Education"];
    
    var favorite_topics = ["Family", "Loneliness", "Time Management"]
    
    var selected_topic = 14;
    
    var currentRole : String!
    
    var ref : FIRDatabaseReference!
    
    override func viewDidLoad() {
        exploreView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        likeView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.9)
        
        if let nav = self.navigationController {
            nav.navigationBarHidden = true
        }
        
        ref = FIRDatabase.database().reference()
        
        loadTopics()
    }
    
    
    @IBAction func searchingForTopic(sender: UITextField) {
        reloadBubbles()
    }
    
    @IBAction func searchedForTopic(sender: UITextField) {
        reloadBubbles()
    }
    
    func loadTopics() {
        ref.child("topics").observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            if snapshot.value is NSNull {
                
            } else {
                let value = snapshot.value as! NSDictionary
                for (key, val) in value {
                    print(key)
                }
            }
            self.reloadBubbles()
        })
        reloadLikedBubbles()
    }
    
    func reloadBubbles() {
        removeAllSubViews(exploreScrollView)
        if var search = searchBar.text {
            search = search.lowercaseString
            var displayIndex = 0
            for i in 0..<topics.count {
                let topic = topics[i].lowercaseString
                if (topic == "friendships" && (search.isEmpty || topic.hasPrefix(search))) {
                    let centerView = UIImageView(image: UIImage(named: "T_friendships"))
                    centerView.frame = CGRectMake(CGFloat(displayIndex)*exploreScrollView.frame.height, 0, exploreScrollView.frame.height, exploreScrollView.frame.height)
                    exploreScrollView.addSubview(centerView)
                    displayIndex += 1
                } else if (topic == "family" && (search.isEmpty || topic.hasPrefix(search))) {
                    let centerView = UIImageView(image: UIImage(named: "T_family"))
                    centerView.frame = CGRectMake(CGFloat(displayIndex)*exploreScrollView.frame.height, 0, exploreScrollView.frame.height, exploreScrollView.frame.height)
                    exploreScrollView.addSubview(centerView)
                    displayIndex += 1
                } else if (topic == "loneliness" && (search.isEmpty || topic.hasPrefix(search))) {
                    let centerView = UIImageView(image: UIImage(named: "T_loneliness"))
                    centerView.frame = CGRectMake(CGFloat(displayIndex)*exploreScrollView.frame.height, 0, exploreScrollView.frame.height, exploreScrollView.frame.height)
                    exploreScrollView.addSubview(centerView)
                    displayIndex += 1
                } else if (topic == "love" && (search.isEmpty || topic.hasPrefix(search))) {
                    let centerView = UIImageView(image: UIImage(named: "T_love"))
                    centerView.frame = CGRectMake(CGFloat(displayIndex)*exploreScrollView.frame.height, 0, exploreScrollView.frame.height, exploreScrollView.frame.height)
                    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(HomeController.goToFeed))
                    centerView.addGestureRecognizer(tapRecognizer)
                    centerView.userInteractionEnabled = true
                    exploreScrollView.addSubview(centerView)
                    displayIndex += 1
                } else if (search.isEmpty || topic.hasPrefix(search)) {
                    let topicView = UIView(frame: CGRectMake(CGFloat(displayIndex) * exploreScrollView.frame.height, 0, exploreScrollView.frame.height, exploreScrollView.frame.height))
                    topicView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.2)
                    
                    let topicLabel = UILabel(frame: CGRectMake(0, 0, exploreScrollView.frame.height, exploreScrollView.frame.height))
                    topicLabel.text = topics[i % topics.count]
                    topicLabel.textColor = UIColor.whiteColor()
                    topicLabel.textAlignment = .Center
                    topicLabel.backgroundColor = UIColor.clearColor()
                    
                    topicView.addSubview(topicLabel)
                    
                    let circle = CAShapeLayer()
                    let imageFrame = topicView.frame
                    let circleRect = CGRect(x: imageFrame.origin.x - CGFloat(displayIndex) * exploreScrollView.frame.height, y: imageFrame.origin.y, width: imageFrame.width, height: imageFrame.height)
                    let circularPath = UIBezierPath(roundedRect: circleRect, byRoundingCorners: UIRectCorner.AllCorners, cornerRadii: CGSize(width: imageFrame.width, height: imageFrame.height))
                    circle.path = circularPath.CGPath
                    circle.lineWidth = 0
                    
                    topicView.layer.mask = circle
                    topicView.layer.masksToBounds = true
                    
                    topicView.tag = i
                    
                    exploreScrollView.addSubview(topicView)
                    displayIndex += 1
                }
            }
            
            exploreScrollView.contentSize = CGSize(width: CGFloat(displayIndex)*exploreScrollView.frame.height, height: exploreScrollView.frame.height)
            
            exploreScrollView.contentOffset = CGPointMake(0,0);
            
        } else {
            exploreScrollView.contentSize = CGSize(width: CGFloat(topics.count)*exploreScrollView.frame.height, height: exploreScrollView.frame.height)
            for i in 0..<topics.count {
                if (topics[i] == "Friendships") {
                    let centerView = UIImageView(image: UIImage(named: "T_friendships"))
                    centerView.frame = CGRectMake(CGFloat(i)*exploreScrollView.frame.height, 0, exploreScrollView.frame.height, exploreScrollView.frame.height)
                    exploreScrollView.addSubview(centerView)
                } else if (topics[i] == "Family") {
                    let centerView = UIImageView(image: UIImage(named: "T_family"))
                    centerView.frame = CGRectMake(CGFloat(i)*exploreScrollView.frame.height, 0, exploreScrollView.frame.height, exploreScrollView.frame.height)
                    exploreScrollView.addSubview(centerView)
                } else if (topics[i] == "Loneliness") {
                    let centerView = UIImageView(image: UIImage(named: "T_loneliness"))
                    centerView.frame = CGRectMake(CGFloat(i)*exploreScrollView.frame.height, 0, exploreScrollView.frame.height, exploreScrollView.frame.height)
                    exploreScrollView.addSubview(centerView)
                } else if (topics[i] == "Love") {
                    let centerView = UIImageView(image: UIImage(named: "T_love"))
                    centerView.frame = CGRectMake(CGFloat(i)*exploreScrollView.frame.height, 0, exploreScrollView.frame.height, exploreScrollView.frame.height)
                    let tapRecognizer = UITapGestureRecognizer(target: self, action: "goToFeed")
                    centerView.addGestureRecognizer(tapRecognizer)
                    centerView.userInteractionEnabled = true
                    exploreScrollView.addSubview(centerView)
                } else {
                    let topicView = UIView(frame: CGRectMake(CGFloat(i) * exploreScrollView.frame.height, 0, exploreScrollView.frame.height, exploreScrollView.frame.height))
                    topicView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.2)
                    
                    let topicLabel = UILabel(frame: CGRectMake(0, 0, exploreScrollView.frame.height, exploreScrollView.frame.height))
                    topicLabel.text = topics[i % topics.count]
                    topicLabel.textColor = UIColor.whiteColor()
                    topicLabel.textAlignment = .Center
                    topicLabel.backgroundColor = UIColor.clearColor()
                    
                    topicView.addSubview(topicLabel)
                    
                    let circle = CAShapeLayer()
                    let imageFrame = topicView.frame
                    let circleRect = CGRect(x: imageFrame.origin.x - CGFloat(i) * exploreScrollView.frame.height, y: imageFrame.origin.y, width: imageFrame.width, height: imageFrame.height)
                    let circularPath = UIBezierPath(roundedRect: circleRect, byRoundingCorners: UIRectCorner.AllCorners, cornerRadii: CGSize(width: imageFrame.width, height: imageFrame.height))
                    circle.path = circularPath.CGPath
                    circle.lineWidth = 0
                    
                    topicView.layer.mask = circle
                    topicView.layer.masksToBounds = true
                    
                    topicView.tag = i
                    
                    exploreScrollView.addSubview(topicView)
                }
            }
        }
    }
    
    func reloadLikedBubbles() {
        removeAllSubViews(likeScrollView)
        likeScrollView.contentSize = CGSize(width: CGFloat(favorite_topics.count)*likeScrollView.frame.height, height: likeScrollView.frame.height)
        for i in 0..<favorite_topics.count {
            let fav_top = favorite_topics[i].lowercaseString
            if (favorite_topics[i] == "Friendships") {
                let centerView = UIImageView(image: UIImage(named: "T_\(fav_top)"))
                centerView.frame = CGRectMake(CGFloat(i) * likeScrollView.frame.height, 0, likeScrollView.frame.height, likeScrollView.frame.height)
                likeScrollView.addSubview(centerView)
            } else if (favorite_topics[i] == "Family") {
                let centerView = UIImageView(image: UIImage(named: "T_\(fav_top)"))
                centerView.frame = CGRectMake(CGFloat(i) * likeScrollView.frame.height, 0, likeScrollView.frame.height, likeScrollView.frame.height)
                likeScrollView.addSubview(centerView)
            } else if (favorite_topics[i] == "Loneliness") {
                let centerView = UIImageView(image: UIImage(named: "T_\(fav_top)"))
                centerView.frame = CGRectMake(CGFloat(i) * likeScrollView.frame.height, 0, likeScrollView.frame.height, likeScrollView.frame.height)
                likeScrollView.addSubview(centerView)
            } else if (favorite_topics[i] == "Love") {
                let centerView = UIImageView(image: UIImage(named: "T_\(fav_top)"))
                centerView.frame = CGRectMake(CGFloat(i) * likeScrollView.frame.height, 0, likeScrollView.frame.height, likeScrollView.frame.height)
                likeScrollView.addSubview(centerView)
            } else {
                let topicView = UIView(frame: CGRectMake(CGFloat(i)*likeScrollView.frame.height, 0, likeScrollView.frame.height, likeScrollView.frame.height))
                topicView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.2)
                
                let topicLabel = UILabel(frame: CGRectMake(0, 0, likeScrollView.frame.height, likeScrollView.frame.height))
                topicLabel.text = favorite_topics[i % favorite_topics.count]
                topicLabel.textColor = UIColor.whiteColor()
                topicLabel.textAlignment = .Center
                topicLabel.backgroundColor = UIColor.clearColor()
                
                topicView.addSubview(topicLabel)
                
                let circle = CAShapeLayer()
                let imageFrame = topicView.frame
                let circleRect = CGRect(x: imageFrame.origin.x - CGFloat(i)*likeScrollView.frame.height, y: imageFrame.origin.y, width: imageFrame.width, height: imageFrame.height)
                let circularPath = UIBezierPath(roundedRect: circleRect, byRoundingCorners: UIRectCorner.AllCorners, cornerRadii: CGSize(width: imageFrame.width, height: imageFrame.height))
                circle.path = circularPath.CGPath
                circle.lineWidth = 0
                
                topicView.layer.mask = circle
                topicView.layer.masksToBounds = true
                
                topicView.tag = i
                
                likeScrollView.addSubview(topicView)
            }
        }
    }
    
    func removeAllSubViews(fullView: UIView) {
        for view in fullView.subviews {
            view.removeFromSuperview()
        }
    }
    
    func goToFeed() {
        self.performSegueWithIdentifier("toFeed", sender: self)
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toFeed" {
            if let controller = segue.destinationViewController as? TopicFeedController {
                controller.currentRole = self.currentRole
            }
        }
    }
}
