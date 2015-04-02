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
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memedImages = (UIApplication.sharedApplication().delegate as AppDelegate).memes
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        memedImages = (UIApplication.sharedApplication().delegate as AppDelegate).memes
        self.collectionView.reloadData()
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
        return rows
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as MemeCollectionViewCell
        let meme = self.memedImages[indexPath.row]
        cell.memeImage.image = meme.memedImage
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath)
    {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController")! as MemeDetailViewController
        let meme = memedImages[indexPath.row]
        controller.meme = meme
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
}
