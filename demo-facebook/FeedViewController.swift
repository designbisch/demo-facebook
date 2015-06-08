//
//  FeedViewController.swift
//  demo-facebook
//
//  Created by Josh Bisch on 6/4/15.
//  Copyright (c) 2015 designbisch. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var thirdImage: UIImageView!
    @IBOutlet weak var fourthImage: UIImageView!
    @IBOutlet weak var fifthImage: UIImageView!
    
    var selectedImageView: UIImageView!
    var imageTransition: ImageTransition!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollView.contentSize = feedImage.image!.size
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapImage(sender: UITapGestureRecognizer) {
        selectedImageView = sender.view as! UIImageView
        performSegueWithIdentifier("photoSegue", sender: self)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        var fromViewController = segue.sourceViewController as! FeedViewController
        var toViewController = segue.destinationViewController as! PhotoViewController
        var identifier = segue.identifier
        
        toViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        
        imageTransition = ImageTransition()
        imageTransition.duration = 0.4
        
        toViewController.transitioningDelegate = imageTransition
        
        toViewController.image = selectedImageView.image
        
    }

}
