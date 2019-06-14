
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class LoginVC: UIViewController {
    
    let myString = StringCollection()
    var isConnected: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkConnection()
    }
    
    
    /*
     check if device can connect to Firebase.
     */
    func checkConnection() {
        let connectedRef = Database.database().reference(withPath: ".info/connected")
        connectedRef.observe(.value, with: { snapshot in
            if snapshot.value as? Bool ?? false {
                self.isConnected = true
                print("Connected")
            } else {
                self.isConnected = false
                print("No Connection")
                
            }
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1)
        {
            if self.isConnected == false
            {
                self.sendAlertError()
            }
        }

    }
    
    /*
     send alert to user if cannot connecct to firebase
     */
    func sendAlertError()
    {
        let alert = UIAlertController(title: "Error", message: "Unable to reach Firebase Authentication, Please re-launch the app", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func goToPatientMenu() {
        performSegue(withIdentifier: self.myString.fromLoginToTabBar, sender: self)
    }
    
    func goToDoctorMenu() {
        performSegue(withIdentifier: myString.toDoctorMainView, sender: self)
    }
    

}



