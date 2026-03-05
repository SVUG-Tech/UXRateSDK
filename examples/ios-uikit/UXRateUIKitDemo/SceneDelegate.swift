import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let window = UIWindow(windowScene: windowScene)

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            createHomeTab(),
            createProfileTab(),
            createSettingsTab(),
        ]

        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        self.window = window
    }

    // MARK: - Tab Factory

    private func createHomeTab() -> UINavigationController {
        let vc = HomeViewController()
        vc.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        return UINavigationController(rootViewController: vc)
    }

    private func createProfileTab() -> UINavigationController {
        let vc = ProfileViewController()
        vc.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 1)
        return UINavigationController(rootViewController: vc)
    }

    private func createSettingsTab() -> UINavigationController {
        let vc = SettingsViewController()
        vc.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)
        return UINavigationController(rootViewController: vc)
    }
}
