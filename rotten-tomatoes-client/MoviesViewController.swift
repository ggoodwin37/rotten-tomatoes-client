//
//  MoviesViewController.swift
//  rotten-tomatoes-client
//
//  Created by Gideon Goodwin on 8/26/15.
//  Copyright © 2015 Gideon Goodwin. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    var movies: [NSDictionary]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let url = NSURL(string: "https://gist.githubusercontent.com/timothy1ee/d1778ca5b944ed974db0/raw/489d812c7ceeec0ac15ab77bf7c47849f2d1eb2b/gistfile1.json")!
        let request = NSURLRequest(URL:url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
            do {
                // TODO: I just want like no options here, wtf
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
                if let json = json {
                    self.movies = json["movies"] as! [NSDictionary]
                    // leaving off at 9:45 on movie 1 at
                    // https://www.youtube.com/watch?v=5pis7jNgN3w&index=1&list=PLrT2tZ9JRrf5IZwc6TYr7vJHrsCXY9lPh
                }
                print(json)
            } catch {
                print("fuckin deserialization error")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
