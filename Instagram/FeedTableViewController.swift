//
//  FeedTableViewController.swift
//  Instagram
//
//  Created by Vikram Nag on 6/8/18.
//  Copyright © 2018 Vikram Nag Ashoka. All rights reserved.
//

import UIKit
import Parse
import AdsNativeSDK


class FeedTableViewController: UITableViewController, ANTableViewAdPlacerDelegate {
 
    var users = [String: String]()
    var captions = [String]()
    var usernames = [String]()
    var imageFiles = [PFFile]()
    var likesCount = [Int]()
    var placer = ANTableViewAdPlacer()
    
    let simpleTableIdentifier = "SimpleTableCell";
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let query = PFUser.query()
        query?.whereKey("username", notEqualTo: PFUser.current()?.username)
        
        query?.findObjectsInBackground(block: { (objects, error) in
            
            if let users = objects{
                for object in users{
                    if let user = object as? PFUser{
                        self.users[user.objectId!] = user.username!
                    }
                }
            }
            
            let getFollowedUserQuery = PFQuery(className: "Following")
            
            getFollowedUserQuery.whereKey("follower", equalTo: PFUser.current()?.objectId)
            getFollowedUserQuery.findObjectsInBackground(block: { (objects, error) in
              
                if let followers = objects{
                    
                    for follower in followers{
                        
                        if let followedUser = follower["following"]{
                            let query = PFQuery(className: "Post")
                            
                            query.whereKey("userId", equalTo: followedUser)
                            
                            query.findObjectsInBackground(block: { (objects, error) in
                                
                                if let posts = objects{
                                    
                                    for post in posts{
                                        
                                        self.captions.append((post["caption"] as? String)!)
                                        self.usernames.append(post["username"] as! String)
                                        self.imageFiles.append(post["imageFile"] as! PFFile)
                                        //self.likesCount.append((post["likes"] as? Int)!)
                                        
                                        
                                        self.tableView.reloadData()
                                        
                                    }
                                }
                            })
                        }
                    }
                }
                
            })
            
        })
        
        
        //Polymorph Ad Integration
        LogSetLevel(LogLevelDebug);
        
        self.tableView.register(UINib(nibName: "FeedTableViewCell", bundle: nil) , forCellReuseIdentifier: simpleTableIdentifier)
        let serverAdPositions = ANServerAdPositions()
        //The defaultRenderingClass can be switched to `ANAdTableViewCellNew` dynamically by specifying it in the AdsNative UI
        
        self.placer = ANTableViewAdPlacer(tableView: self.tableView, viewController: self, adPositions:serverAdPositions, defaultAdRenderingClass: NativeAdView.self)
        
        self.placer.delegate = self
        
        self.placer.loadAds(forAdUnitID: "ping")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return captions.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedTableViewCell

        // Configure the cell...
        imageFiles[indexPath.row].getDataInBackground { (data, error) in
            if let imageData = data{
                if let image = UIImage(data: imageData){
                    cell.postedImage.image = image
                    
                }
            }
        }
        
        cell.caption.text = captions[indexPath.row]
        if let endIndex = usernames[indexPath.row].range(of: "@")?.lowerBound{
            cell.userInfo.text = String(usernames[indexPath.row][..<endIndex])
        }
        
        cell.caption.textColor = UIColor.black
        cell.userInfo.textColor = UIColor.black
        //if likesCount[indexPath.row]
        //cell.likeCountDisplay.text = String(likesCount[indexPath.row]) + " likes"

        cell.layer.borderWidth = CGFloat(10)
        cell.layer.borderColor = tableView.backgroundColor?.cgColor
        
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
    
    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}






