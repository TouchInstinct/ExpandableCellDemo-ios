import UIKit

@UIApplicationMain
class AppDelegate: UIResponder {

    let window = UIWindow(frame: UIScreen.main.bounds)

}

extension AppDelegate: UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window.rootViewController = UINavigationController(rootViewController: MainViewController())
        window.makeKeyAndVisible()

        return true
    }

}
