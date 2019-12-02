//
//  RegisterViewController.swift
//  Arabic Learning
//
//  Created by Muhammad Mujtaba on 10/13/19.
//  Copyright © 2019 Muhammad Mujtaba. All rights reserved.
//

import Foundation
import Firebase
import SVProgressHUD

import UIKit

class RegisterViewController: UIViewController{
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var confirmpassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func RegisterButtonPressed(_ sender: Any) {
        SVProgressHUD.show()
        if(userName.text == ""){
            SVProgressHUD.dismiss()
            ProgressHUD.showError("Error: Fill Missing Field")
        }
        else if(userPassword.text == confirmpassword.text){
            Auth.auth().createUser(withEmail: userEmail.text!, password: userPassword.text!) {
                
                (user, error) in
                if error != nil{
                    print("error")
                    SVProgressHUD.dismiss()
                    ProgressHUD.showError("Error in Registration? Try with new id/password")
                    print("error")
                }else{
                    print("Sucessful")
                    let userID = Auth.auth().currentUser!.uid
                    let databaseReference = Database.database().reference().child("/Users")
                    let newUser = ["name":self.userName.text!,"email":self.userEmail.text!,"ID":userID]
                    databaseReference.child(userID).setValue(newUser){
                        (error,reference) in
                        if error != nil {
                            SVProgressHUD.dismiss()
                            ProgressHUD.showError("Internet Error")
                        }else{
                            SVProgressHUD.dismiss()
                            print("Sent")
                        }
                    }

                    self.performSegue(withIdentifier: "goToHome", sender: self)
                }
            }

        }
        else{
            ProgressHUD.showError("Error : Password mismatch")
            SVProgressHUD.dismiss()
        }
    }
}
