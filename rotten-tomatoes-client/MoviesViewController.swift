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
    @IBOutlet weak var errorView: UIView!

    var movies: [NSDictionary]?
    var refreshControl: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        MBProgressHUD.showHUDAddedTo(self.view, animated: false)
        self.errorView.hidden = true
        self.tableView.dataSource = self
        self.tableView.delegate = self
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.insertSubview(refreshControl, atIndex: 0)

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

            // just clean up all the things. if this was real code I would make this cleaner, I swear
            MBProgressHUD.hideHUDForView(self.view, animated: false)
            self.refreshControl.endRefreshing()
            self.errorView.hidden = true

            if let data = data {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSDictionary
                    if let json = json {
                        self.movies = json["movies"] as? [NSDictionary]
                        self.tableView.reloadData()
                        print(self.movies)
                    }
                } catch {
                    self.onNetworkError()
                    print("fuckin deserialization error what is this bullshit")
                }
            } else {
                self.onNetworkError()
                print("failed to get data, the internet is saying Fuck You")
            }
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.movies != nil) {
            return self.movies!.count
        }
        return 0
    }

    func onNetworkError() {
        self.errorView.hidden = false
    }

    func onRefresh() {
        self.loadData()
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
            print("no image url, you really fucked this one up")
        }
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
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
