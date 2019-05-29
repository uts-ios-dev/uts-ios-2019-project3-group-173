
import UIKit
import Firebase

class LoginVC: UIViewController {

    let myString = StringCollection()
   
    @IBOutlet weak var logoTopConstraintHeight: NSLayoutConstraint!
    @IBOutlet weak var topConstraintHeight: NSLayoutConstraint!
    
    @IBAction func ShowSignInPop(_ sender: Any) {
        topConstraintHeight.constant = 100
        logoTopConstraintHeight.constant = 100
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseOut, animations: {self.view.layoutIfNeeded()}, completion: nil)
        
        print("clicked")
    }
    
//    @IBAction func hideSignInPop(_ sender: Any) {
//        topConstraintHeight.constant = 800
//        logoTopConstraintHeight.constant = 238
//        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseOut, animations: {self.view.layoutIfNeeded()}, completion: nil)
//        print("clicked")
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
       topConstraintHeight.constant = 200
        logoTopConstraintHeight.constant = 238
    
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    
    func checkLogined() {
        if Auth.auth().currentUser != nil
        {
            print("Current User valid \(Auth.auth().currentUser!.uid)")
            goToPatientMenu()
        }
        else
        {
            print("No Current User")
        }
        
    }
    
    
    
    func goToPatientMenu() {
        performSegue(withIdentifier: myString.toPatientMainView, sender: self)
    }
    
    func goToDoctorMenu() {
        performSegue(withIdentifier: myString.toDoctorMainView, sender: self)
    }
    
    
}

