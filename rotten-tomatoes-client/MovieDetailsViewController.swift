//
//  MovieDetailsViewController.swift
//  rotten-tomatoes-client
//
//  Created by Gideon Goodwin on 8/28/15.
//  Copyright © 2015 Gideon Goodwin. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!

    var movie: NSDictionary!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = movie["title"] as? String
        self.synopsisLabel.text = movie["synopsis"] as? String

        let imageUrl = NSURL(string: movie.valueForKeyPath("posters.thumbnail") as! String)
        if let imageUrl = imageUrl {
            self.posterImageView.setImageWithURL(imageUrl)
        } else {
            print("no image url, fuck you")
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
