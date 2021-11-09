//
//  FirstViewController.swift 
//
//  Created by Madhawa Jayagoda on 2021-05-12.
//


import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var guestLogInBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide the NavigationBar at the Top
        self.navigationController?.isNavigationBarHidden = true
         
	}
}
