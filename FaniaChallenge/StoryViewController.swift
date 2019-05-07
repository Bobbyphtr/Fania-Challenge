//
//  StoryViewController.swift
//  FaniaChallenge
//
//  Created by BobbyPhtr on 30/04/19.
//  Copyright © 2019 BobbyPhtr. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension StoryViewController: swipeGestureDelegate {
    func didSwipe(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == UISwipeGestureRecognizer.Direction.right {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: UIView.AnimationOptions.curveEaseOut, animations: {
                
            }) { (_) in
                //Completion code
            }
        }
        else if gesture.direction == UISwipeGestureRecognizer.Direction.left {
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: UIView.AnimationOptions.curveEaseOut, animations: {
               
            }) { (_) in
                //Completion code
            }
        }
    }
}
