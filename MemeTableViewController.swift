//
//  MemeTableViewController.swift
//  Meme_prep
//
//  Created by Taiowa Waner on 4/1/15.
//  Copyright (c) 2015 Taiowa Waner. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var memedImages: [Meme]!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.memedImages = (UIApplication.sharedApplication().delegate as AppDelegate).memes
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
//        let object = UIApplication.sharedApplication().delegate
//        let appDelegate = object as AppDelegate
//        self.memedImages = (UIApplication.sharedApplication().delegate as AppDelegate).memes
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TableViewDelegate Methods
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        let meme = memedImages[indexPath.row]
        cell.textLabel?.text = meme.topText
        cell.imageView?.image = meme.memedImage
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0
        if let memes = memedImages {
            rows = memes.count
        } else {
            rows = 0
        }
        return rows
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController")! as MemeDetailViewController
        let meme = memedImages[indexPath.row]
        controller.meme = meme
        self.navigationController?.pushViewController(controller, animated: true)
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
