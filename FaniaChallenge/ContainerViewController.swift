//
//  ContainerViewController.swift
//  FaniaChallenge
//
//  Created by BobbyPhtr on 29/04/19.
//  Copyright © 2019 BobbyPhtr. All rights reserved.
//

import UIKit

protocol swipeGestureDelegate {
    func didSwipe(gesture: UISwipeGestureRecognizer)
}

class ContainerViewController: UIViewController {
    
    var swipeDelegate: swipeGestureDelegate!
    
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var separatorLine: UIView!
    
    private lazy var profileViewController: ProfileController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "profileView") as! ProfileController
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    private lazy var skillViewController: SkillViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "skillView") as! SkillViewController
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    private lazy var storyViewController: StoryViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "storyView") as! StoryViewController
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        self.viewContent.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        self.viewContent.addGestureRecognizer(swipeRight)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        self.viewContent.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        self.viewContent.addGestureRecognizer(swipeDown)
        
        add(asChildViewController: profileViewController)
        //print("init()")
        // Do any additional setup after loading the view.
        let masterViewController = self.children[0] as! MasterViewController
        masterViewController.changeViewDelegate = self
        
        //need penyesuaian
        
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizer.Direction.right {
            print("Swipe Right")
            swipeDelegate.didSwipe(gesture: gesture)
            
        }
        else if gesture.direction == UISwipeGestureRecognizer.Direction.left {
            print("Swipe Left")
            swipeDelegate.didSwipe(gesture: gesture)

        }
        else if gesture.direction == UISwipeGestureRecognizer.Direction.up {
            print("Swipe Up")
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: UIView.AnimationOptions.curveEaseIn, animations: {
                self.viewContent.transform = CGAffineTransform(translationX: 0, y: -80)
                self.separatorLine.transform = CGAffineTransform(translationX: 0, y: -80)
            })
        }
        else if gesture.direction == UISwipeGestureRecognizer.Direction.down {
            print("Swipe Down")
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: UIView.AnimationOptions.curveEaseIn, animations: {
                self.viewContent.transform = CGAffineTransform(translationX: 0, y: 0)
                self.separatorLine.transform = CGAffineTransform(translationX: 0, y: 0)
            })
            
        }
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChild(viewController)
        
        // Add Child View as Subview
        viewContent.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = viewContent.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)
        swipeDelegate = self.children[1] as? swipeGestureDelegate
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParent()
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

extension ContainerViewController: changeViewDelegate{
    //Story = 0, Profile = 1, Skills = 2
    
    func onClickButton(from: Int, to: Int) {
//        let myView = self.storyboard?.instantiateViewController(withIdentifier: "profileView") as! ProfileController
//        present(myView, animated: false, completion: nil)
        
        switch from {
        case 0:
            remove(asChildViewController: storyViewController)
            switch to {
            case 0:
                add(asChildViewController: storyViewController)
            case 1:
                add(asChildViewController: profileViewController)
            case 2:
                add(asChildViewController: skillViewController)
            default:
                print("Error on change childView")
            }
        case 1:
            remove(asChildViewController: profileViewController)
            switch to {
            case 0:
                add(asChildViewController: storyViewController)
            case 1:
                add(asChildViewController: profileViewController)
            case 2:
                add(asChildViewController: skillViewController)
            default:
                print("Error on change childView")
            }
        case 2:
            remove(asChildViewController: skillViewController)
            switch to {
            case 0:
                add(asChildViewController: storyViewController)
            case 1:
                add(asChildViewController: profileViewController)
            case 2:
                add(asChildViewController: skillViewController)
            default:
                print("Error on change childView")
            }
        default:
            print("Error on clicked")
        }
        print(self.children)
    }
}
