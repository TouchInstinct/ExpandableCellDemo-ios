import UIKit

extension UIApplication {

    var appDelegate: AppDelegate {
        guard let appDelegate = delegate as? AppDelegate else {
            fatalError("No AppDelegate")
        }

        return appDelegate
    }

}
