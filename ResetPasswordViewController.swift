
//
//  ResetPasswordViewController.swift
//  Assignment 03
//
//  Created by Madhawa Jayagoda on 2021-05-18.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var resetPwdTextFiled: UITextField!
    @IBOutlet weak var confResetPwdTextFiled: UITextField!
    
    @IBOutlet weak var resetPwdBtn: UIButton!
    
    var pwdShowIconClick = false
    var vryPwdShowIconClicked = false
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: UIViewController lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        resetPwdTextFiled.layer.cornerRadius = 5
        resetPwdTextFiled.layer.masksToBounds = true
        resetPwdTextFiled.layer.borderWidth = 1.5
        resetPwdTextFiled.layer.borderColor = UIColor(red: 0.51, green: 0.51, blue: 0.52, alpha: 1.00).cgColor
        resetPwdTextFiled.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        confResetPwdTextFiled.layer.cornerRadius = 5
        confResetPwdTextFiled.layer.masksToBounds = true
        confResetPwdTextFiled.layer.borderWidth = 1.5
        confResetPwdTextFiled.layer.borderColor = UIColor(red: 0.51, green: 0.51, blue: 0.52, alpha: 1.00).cgColor
        confResetPwdTextFiled.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        resetPwdTextFiled.layer.cornerRadius = 5
        
        let uiImage = UIImage(named: "password_view" )
        let uiImageViewNewPwd = resetPwdTextFiled.rightImage( uiImage, imageWidth: 20, padding: 20)
        let uiImageViewVryPwd = confResetPwdTextFiled.rightImage( uiImage, imageWidth: 20, padding: 20)
        
        // create tap gesture recognizer for Password and Verify Password
        let tapGestureNewPwd = UITapGestureRecognizer(target: self, action: #selector(self.imageTappedPwd(tapGestureRecognizer:)))
        let tapGestureVryPwd = UITapGestureRecognizer(target: self, action: #selector(self.imageTappedVryPwd(tapGestureRecognizer:)))


        // add it to the imageView - new password;
        uiImageViewNewPwd.addGestureRecognizer(tapGestureNewPwd)
        // make sure imageView can be interacted with by user
        uiImageViewNewPwd.isUserInteractionEnabled = true
        
        // add it to the imageView - Verify Password;
        uiImageViewVryPwd.addGestureRecognizer(tapGestureVryPwd)
        // make sure imageView can be interacted with by user
        uiImageViewVryPwd.isUserInteractionEnabled = true
    }
}
    


// Button Actions
extension ResetPasswordViewController {
    @IBAction func resetPwdBtnClicked(_ sender: UIButton) {
        if ( !(resetPwdTextFiled.text?.isEmpty ?? true) && !(confResetPwdTextFiled.text?.isEmpty ?? true)) {
            // Both the new password and confirm password fileds are filled by the User
            if ( resetPwdTextFiled.text! == confResetPwdTextFiled.text! ){
                // reset Password and Confirm password match
                do{
                    // UserDefaults Instance
                    let defaults = UserDefaults.standard
                    
                    // Fetch the email address from UserDefaults temporary variable
                    let temp_userEmail = defaults.value(forKey: "UserEmailTemp") as! String
                    print("Temporary User Email: \(temp_userEmail)")
                    
                    var userArray = [User]()
                    userArray = try context.fetch(User.fetchSpecificUser(email: temp_userEmail))
                    
                    if userArray.count > 0 {
                        // retrieve the Specific User to update
                        let updateUser = userArray.first!
                        updateUser.setValue(resetPwdTextFiled.text! , forKey: "password")
                        try context.save()
                        
                        // Show alert that User Password changed successsfully
                        let alert = UIAlertController(title: "? Successfully changed Password", message: "\n Password changed successfully", preferredStyle: UIAlertController.Style.alert)
                        alert.setValue(NSAttributedString(string: alert.title!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor : UIColor(red: 0.16, green: 0.71, blue: 0.39, alpha: 1.00)]), forKey: "attributedTitle")
                        


// add an action (button) 
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
                           
                            // Navigate back to the Root viewController
                            self.navigationController?.popToRootViewController(animated: true)
                        }))
                        // show the alert
                        self.present(alert, animated: true, completion: nil)
                        
                    } else {
                        // No data returned
                        // create the alert -
                        let alert = UIAlertController(title: "Error", message: "Something went wrong! \n Please try again", preferredStyle: UIAlertController.Style.alert)
                        alert.setValue(NSAttributedString(string: alert.title!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor : UIColor.red]), forKey: "attributedTitle")
                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))


                        // show the alert
                        self.present(alert, animated: true, completion: nil)
                    }
                } catch {
                    print("ResetPasswordViewController: Error occured while retrieving data from the database")
                }
                
            } else {
                // create the alert - password and verify password does not match
                let alert = UIAlertController(title: "Error", message: "Password and Confirm Password fields does not match! \n Please check again", preferredStyle: UIAlertController.Style.alert)
                alert.setValue(NSAttributedString(string: alert.title!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor : UIColor.red]), forKey: "attributedTitle")
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))


                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
            
        } else {
            // One or more fields are empty
            
            // create the alert - one or more fields are empty
            let alert = UIAlertController(title: "Error", message: "One or more fields are empty! \n Please fill all the fields to reset your password", preferredStyle: UIAlertController.Style.alert)
            alert.setValue(NSAttributedString(string: alert.title!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor : UIColor.red]), forKey: "attributedTitle")
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))


            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        let forgetPwdViewController = self.storyboard?.instantiateViewController(identifier: "ForgetPasswordViewController") as! ForgetPasswordViewController
        self.navigationController?.pushViewController(forgetPwdViewController, animated: true)
    }
    
    @IBAction func aboutUsBtnClicked(_ sender: UIButton) {
        let aboutUsViewController = self.storyboard?.instantiateViewController(identifier: "AboutUsViewController") as! AboutUsViewController
        self.present(aboutUsViewController, animated: true, completion: nil)
    }
}


// MARK:Custom Methods
extension ResetPasswordViewController {
    @objc private func imageTappedPwd(tapGestureRecognizer: UITapGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        if let _ = tapGestureRecognizer.view as? UIImageView {
            //print("Image Tapped on the Password")
            
            // Toggle the Boolean value
            self.pwdShowIconClick = !(self.pwdShowIconClick)
            
            if pwdShowIconClick {
                // Show the Password
                resetPwdTextFiled.isSecureTextEntry = false
            } else {
                // Hide the Password
                resetPwdTextFiled.isSecureTextEntry = true
            }


        }
        
    }
    
    @objc private func imageTappedVryPwd(tapGestureRecognizer: UITapGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        if let _ = tapGestureRecognizer.view as? UIImageView {
            //print("Image Tapped on the Verify Password")
            
            // Toggle the Boolean value
            self.vryPwdShowIconClicked = !(self.vryPwdShowIconClicked)
            
            if vryPwdShowIconClicked {
                // Show the Password
                confResetPwdTextFiled.isSecureTextEntry = false
            } else {
                // Hide the Password
                confResetPwdTextFiled.isSecureTextEntry = true
            }
        }
    }
}
