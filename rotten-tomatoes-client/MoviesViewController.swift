//
//  MoviesViewController.swift
//  rotten-tomatoes-client
//
//  Created by Gideon Goodwin on 8/26/15.
//  Copyright © 2015 Gideon Goodwin. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!

    var movies: [NSDictionary]?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func loadData() {
        let url = NSURL(string: "https://gist.githubusercontent.com/timothy1ee/d1778ca5b944ed974db0/raw/489d812c7ceeec0ac15ab77bf7c47849f2d1eb2b/gistfile1.json")!
        let request = NSURLRequest(URL:url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
            if let data = data {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSDictionary
                    if let json = json {
                        self.movies = json["movies"] as? [NSDictionary]
                        self.tableView.reloadData()
                        print(self.movies)
                    }
                } catch {
                    print("fuckin deserialization error")
                }
            } else {
                print("failed to get data, suck")
            }
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.movies != nil) {
            return self.movies!.count
        }
        return 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("com.ggoodwin.ios-rotten-tomatoes-cell", forIndexPath:indexPath) as! MovieCell
        let movie = self.movies![indexPath.row]
        cell.titleLabel.text = movie["title"] as? String
        cell.synopsisLabel.text = movie["synopsis"] as? String

        let imageUrl = NSURL(string: movie.valueForKeyPath("posters.thumbnail") as! String)
        if let imageUrl = imageUrl {
            cell.posterImageView.setImageWithURL(imageUrl)
        } else {
            print("no image url, fuck you")
        }
        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)!
        let movie = self.movies![indexPath.row]
        let movieDetailsViewController = segue.destinationViewController as! MovieDetailsViewController
        movieDetailsViewController.movie = movie
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
