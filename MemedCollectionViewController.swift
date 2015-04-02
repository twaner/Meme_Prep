//
//  MemedCollectionViewController.swift
//  Meme_prep
//
//  Created by Taiowa Waner on 4/1/15.
//  Copyright (c) 2015 Taiowa Waner. All rights reserved.
//

import UIKit

class MemedCollectionViewController: UIViewController, UICollectionViewDataSource {

    var memedImages: [Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        memedImages = (UIApplication.sharedApplication().delegate as AppDelegate).memes
        println(memedImages.count)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - CollectionViewDataSource Methods
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var rows = 0
        if let memes = memedImages {
            rows = memes.count
            println("items in section \(rows)")
        } else {
            rows = 0
        }
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as MemeCollectionViewCell
        let meme = self.memedImages[indexPath.row]
        cell.memeImage.image = meme.image
        return cell
//        let meme = memedImages[indexPath.row]
//        cell.textLabel?.text = meme.topText
//        cell.imageView?.image = meme.memedImage
//        return cell

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
