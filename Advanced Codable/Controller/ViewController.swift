//
//  ViewController.swift
//  Advanced Codable
//
//  Created by Brendan Krekeler on 2/20/19.
//  Copyright © 2019 Brendan Krekeler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var foodArray = [Food]()
    var podcastArray: RSSFeed?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let food = FoodLoader.load(jsonFileName: "food") {
            foodArray = food
        } else {
            print("uh oh")
        }
        
        if let rssFeed = PodcastLoader.load(jsonFileName: "podcasts") {
            podcastArray = rssFeed
            
        } else {
            print("podcast uh oh")
        }
        tableView.reloadData()
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Example 1: Different JSON Structure"
        case 1:
            return "Example 2: Multiple Date Formats"
        default:
            return ""
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath) as! FoodTableViewCell
            cell.jsonView.text = foodArray.description
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "podcastCell", for: indexPath) as! PodcastTableViewCell
            if let podcastArray = podcastArray {
                let prePodcastText = podcastArray.feed.title + "\n" + podcastArray.feed.country
                let secondPrePodcastText = "\n" + podcastArray.feed.updated.description
                let podcastText = "\n\n \(podcastArray.feed.podcasts.description)"
                cell.jsonView.text = prePodcastText + secondPrePodcastText + podcastText
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath)
            
            
            return cell
        }
        
    }
    
    

}

