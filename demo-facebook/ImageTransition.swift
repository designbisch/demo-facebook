//
//  ImageTransition.swift
//  demo-facebook
//
//  Created by Josh Bisch on 6/4/15.
//  Copyright (c) 2015 designbisch. All rights reserved.
//

import UIKit

class ImageTransition: BaseTransition {
    
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        var feedViewController = (fromViewController as! UITabBarController).selectedViewController as! FeedViewController
        feedViewController.selectedImageView.hidden = true
        
        var photoViewController = toViewController as! PhotoViewController
        photoViewController.imageView.hidden = true        
        
        //Create copy object to transition
        var movingImageView = UIImageView(image: feedViewController.selectedImageView.image)
        containerView.addSubview(movingImageView)
        movingImageView.contentMode = feedViewController.selectedImageView.contentMode
        movingImageView.clipsToBounds = feedViewController.selectedImageView.clipsToBounds
        
        //Store starting position within scroll view
        var frame = containerView.convertRect(feedViewController.selectedImageView.frame, fromView: feedViewController.scrollView)
        movingImageView.frame = frame
        
        toViewController.view.alpha = 0        
        UIView.animateWithDuration(duration, animations: {
            toViewController.view.alpha = 1
            movingImageView.contentMode = photoViewController.imageView.contentMode
            movingImageView.frame = photoViewController.imageView.frame
            
            }) { (finished: Bool) -> Void in
                self.finish()
                photoViewController.imageView.hidden = false
                movingImageView.removeFromSuperview()
        }
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        var feedViewController = (toViewController as! UITabBarController).selectedViewController as! FeedViewController
        feedViewController.selectedImageView.hidden = true
        
        var photoViewController = fromViewController as! PhotoViewController
        photoViewController.imageView.hidden = true
        
        //Create copy of selected image
        var movingImageView = UIImageView(image: photoViewController.imageView.image)
        containerView.addSubview(movingImageView)
        movingImageView.contentMode = photoViewController.imageView.contentMode
        movingImageView.clipsToBounds = photoViewController.imageView.clipsToBounds
        
        //Store starting position within scroll view
        var framePhoto = containerView.convertRect(photoViewController.imageView.frame, fromView: photoViewController.scrollView)
        movingImageView.frame = framePhoto
        
        //Store ending position within scroll view
        var frameFeed = containerView.convertRect(feedViewController.selectedImageView.frame, fromView: feedViewController.scrollView)
        
        fromViewController.view.alpha = 1
        UIView.animateWithDuration(duration, animations: {
            fromViewController.view.alpha = 0
            movingImageView.contentMode = feedViewController.selectedImageView.contentMode
            movingImageView.frame = frameFeed
            
            }) { (finished: Bool) -> Void in
                self.finish()
                feedViewController.selectedImageView.hidden = false
                movingImageView.removeFromSuperview()
        }
    }
}
