//
//  HomeController.swift
//  JCChat
//
//  Created by Jamar Brooks on 11/5/16.
//  Copyright © 2016 Grace Lam. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

    @IBOutlet var likeScrollView : UIScrollView!
    
    @IBOutlet var exploreScrollView : UIScrollView!
    
    var topics = ["Depression", "Breakups", "Encouragement", "Family", "Divorce", "Abuse",
        "Loneliness",
        "Pride",
        "Jealousy", "Confidence", "Time Management", "Balance", "Friendships", "Doubts", "Love", "Stress", "Education"];
    
    var favorite_topics = ["Family", "Loneliness", "Time Management"]
    
    override func viewDidLoad() {
        exploreScrollView.contentSize = CGSize(width: CGFloat(topics.count*300), height: exploreScrollView.frame.height)
        for i in 0..<topics.count {
            if (topics[i] == "Friendships") {
                let centerView = UIImageView(image: UIImage(named: "T_friendship"))
                centerView.frame = CGRectMake(CGFloat(i*300), 0, 300, exploreScrollView.frame.height)
                exploreScrollView.addSubview(centerView)
            } else if (topics[i] == "Family") {
                let centerView = UIImageView(image: UIImage(named: "T_family"))
                centerView.frame = CGRectMake(CGFloat(i*300), 0, 300, exploreScrollView.frame.height)
                exploreScrollView.addSubview(centerView)
            } else if (topics[i] == "Loneliness") {
                let centerView = UIImageView(image: UIImage(named: "T_loneliness"))
                centerView.frame = CGRectMake(CGFloat(i*300), 0, 300, exploreScrollView.frame.height)
                exploreScrollView.addSubview(centerView)
            } else if (topics[i] == "Love") {
                let centerView = UIImageView(image: UIImage(named: "T_love"))
                centerView.frame = CGRectMake(CGFloat(i*300), 0, 300, exploreScrollView.frame.height)
                exploreScrollView.addSubview(centerView)
            } else {
                let topicView = UIView(frame: CGRectMake(CGFloat(i*300), 0, 300, exploreScrollView.frame.height))
                topicView.backgroundColor = UIColor.init(red: CGFloat(i) / 15, green: CGFloat(i) / 15, blue: CGFloat(i) / 15, alpha: 0.2)
                
                let topicLabel = UILabel(frame: CGRectMake(0, 0, 300, exploreScrollView.frame.height))
                topicLabel.text = topics[i % topics.count]
                topicLabel.textColor = UIColor.whiteColor()
                topicLabel.textAlignment = .Center
                topicLabel.backgroundColor = UIColor.clearColor()
                
                topicView.addSubview(topicLabel)
                
                exploreScrollView.addSubview(topicView)
            }
        }
        
        likeScrollView.contentSize = CGSize(width: CGFloat(favorite_topics.count*300), height: likeScrollView.frame.height)
        for i in 0..<favorite_topics.count {
            if (favorite_topics[i] == "Friendship") {
                let centerView = UIImageView(image: UIImage(named: "T_friendship"))
                centerView.frame = CGRectMake(CGFloat(i*300), 0, 300, likeScrollView.frame.height)
                likeScrollView.addSubview(centerView)
            } else if (favorite_topics[i] == "Family") {
                let centerView = UIImageView(image: UIImage(named: "T_family"))
                centerView.frame = CGRectMake(CGFloat(i*300), 0, 300, likeScrollView.frame.height)
                likeScrollView.addSubview(centerView)
            } else if (favorite_topics[i] == "Loneliness") {
                let centerView = UIImageView(image: UIImage(named: "T_loneliness"))
                centerView.frame = CGRectMake(CGFloat(i*300), 0, 300, likeScrollView.frame.height)
                likeScrollView.addSubview(centerView)
            } else if (favorite_topics[i] == "Love") {
                let centerView = UIImageView(image: UIImage(named: "T_love"))
                centerView.frame = CGRectMake(CGFloat(i*300), 0, 300, likeScrollView.frame.height)
                likeScrollView.addSubview(centerView)
            } else {
                let topicView = UIView(frame: CGRectMake(CGFloat(i*300), 0, 300, likeScrollView.frame.height))
                topicView.backgroundColor = UIColor.init(red: CGFloat(i) / 15, green: CGFloat(i) / 15, blue: CGFloat(i) / 15, alpha: 0.2)
                
                let topicLabel = UILabel(frame: CGRectMake(0, 0, 300, likeScrollView.frame.height))
                topicLabel.text = favorite_topics[i % favorite_topics.count]
                topicLabel.textColor = UIColor.whiteColor()
                topicLabel.textAlignment = .Center
                topicLabel.backgroundColor = UIColor.clearColor()
                
                topicView.addSubview(topicLabel)
                
                likeScrollView.addSubview(topicView)
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
}
