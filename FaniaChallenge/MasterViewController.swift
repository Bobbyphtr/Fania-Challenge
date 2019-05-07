//
//  ViewController.swift
//  FaniaChallenge
//
//  Created by BobbyPhtr on 22/04/19.
//  Copyright © 2019 BobbyPhtr. All rights reserved.
//

import UIKit

protocol changeViewDelegate {
    func onClickButton(from: Int, to: Int)
}

class MasterViewController: UIViewController {

    @IBOutlet weak var storyButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var skillsButton: UIButton!
    
    //0 : Story ; 1 : Profile ; 2 : Skills
    
    var activeStatus: Int = 1
    var changeViewDelegate: changeViewDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        profileButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        activeStatus = 1
        //changeViewDelegate = self.children[0] as? changeViewDelegate
    }
    
    @IBAction func skillButtonOnClick(_ sender: Any) {
        changeViewDelegate.onClickButton(from: activeStatus, to: 2)
        activeStatus = 2
    }
    
    @IBAction func storyButtonClicked(_ sender: Any) {
        changeViewDelegate.onClickButton(from: activeStatus, to: 0)
        activeStatus = 0
    }
    @IBAction func profileButtonClicked(_ sender: Any) {
        changeViewDelegate.onClickButton(from: activeStatus, to: 1)
        activeStatus = 1
    }
    
}

