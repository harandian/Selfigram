//
//  NewsFeedController.swift
//  Selfigram
//
//  Created by Hirad on 1/24/17.
//  Copyright © 2017 Hirad. All rights reserved.
//

import UIKit

var words = ["Hello", "my", "name", "is", "Selfigram"]
class NewsFeedController: UITableViewController {

    var posts = [Post]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=ec825eb367672f482d101fad3c1b5711&tags=cat")!
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) -> Void in
            
            if let jsonUnformatted = try? JSONSerialization.jsonObject(with: data!, options: []){
            
                let json = jsonUnformatted as? [String: AnyObject]
                let photoDictionary = json? ["photos"] as? [String: AnyObject]
                if let photosArray = photoDictionary?["photo"] as? [[String : AnyObject]] {
                    
                    print("\(photosArray)")
                    for photo in photosArray {
                        
                        if let farmID = photo["farm"] as? Int,
                            let serverID = photo["server"] as? String,
                            let photoID = photo["id"] as? String,
                            let secret = photo["secret"] as? String {
                        
                            let photoURLString = "https://farm\(farmID).staticflickr.com/\(serverID)/\(photoID)_\(secret).jpg"
                            print (photoURLString)
                            
                            if let photoURL = URL (string: photoURLString){
                                 let me = User(aUserName: "Hirad", aProfileImage: UIImage(named: "Grumpy-Cat")!)
                                let post = Post(imageURL: photoURL, user: me, comment: "A Flickr Selfie")
                                self.posts.append(post)
                                
                            }
                            
                        }
                        
                    }
                    
                    OperationQueue.main.addOperation {
                        self.tableView.reloadData()
                    }
                    
                }
            
        }else {
                
                print ("inside dataTaskWithURL with data = \(data!)")
            }
            
        })
        
        task.resume()
        print ("outside dataTaskWithURL")


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let me = User(aUserName: "Hirad", aProfileImage: UIImage(named: "Grumpy-Cat")!)
//        let post0 = Post(image: UIImage(named: "Grumpy-Cat")! , user: me, comment: "Confused01")
//        let post1 = Post(image: UIImage(named: "Grumpy-Cat")! , user: me, comment: "Confused02")
//        let post2 = Post(image: UIImage(named: "Grumpy-Cat")! , user: me, comment: "Confused03")
//        let post3 = Post(image: UIImage(named: "Grumpy-Cat")! , user: me, comment: "Confused04")
//        let post4 = Post(image: UIImage(named: "Grumpy-Cat")! , user: me, comment: "Confused05")
        
//        posts = [post0, post1, post2, post3, post4]
        
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
        return self.posts.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)
        
        // Configure the cell...
        
        let post = posts[indexPath.row]
        cell.imageView?.image = nil
        let task = URLSession.shared.downloadTask(with: post.imageURL, completionHandler: {(data, response, error) -> Void in
            if let imageURL = data, let imageData = try? Data(contentsOf: imageURL){
                OperationQueue.main.addOperation{
                    cell.selfieImageView.image = UIImage(data: imageData)
                    
                }
            }
        }
        
    }
    
    task.resume()
    cell.textLabel?.text = post.comment
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
