//
//  PhotoViewController.swift
//  demo-facebook
//
//  Created by Josh Bisch on 6/4/15.
//  Copyright (c) 2015 designbisch. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var buttonImages: UIImageView!
    
    var image: UIImage!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.image = image
        scrollView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapDoneBtn(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // This method is called as the user scrolls
        var offset = Float(scrollView.contentOffset.y)
        
        var scrollUp = convertValue(offset, r1Min: 0, r1Max: 70, r2Min: 1, r2Max: 0.8)
        var scrollDown = convertValue(offset, r1Min: -70, r1Max: 0, r2Min: 0.8, r2Max: 1)
        
        if offset < 0 {
            view.backgroundColor = UIColor(white: 0, alpha: (CGFloat(scrollDown)))
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.doneBtn.alpha = 0
                self.buttonImages.alpha = 0
            })
        } else if offset > 0{
            view.backgroundColor = UIColor(white: 0, alpha: (CGFloat(scrollUp)))
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.doneBtn.alpha = 0
                self.buttonImages.alpha = 0
            })
        } else {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.doneBtn.alpha = 1
                self.buttonImages.alpha = 1
            })
        }
        
        println("content offset: \(scrollView.contentOffset.y)")
        
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        var offset = Float(scrollView.contentOffset.y)
        
        if offset <= -70 {
            dismissViewControllerAnimated(true, completion: nil)
        } else if offset >= 70{
            dismissViewControllerAnimated(true, completion: nil)
        }
        
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func convertValue(value: Float, r1Min: Float, r1Max: Float, r2Min: Float, r2Max: Float) -> Float {
        var ratio = (r2Max - r2Min) / (r1Max - r1Min)
        return value * ratio + r2Min - r1Min * ratio
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
