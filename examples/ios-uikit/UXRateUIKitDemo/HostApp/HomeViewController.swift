import UIKit
import UXRateSDK

/// Pure UIKit home screen — auto-tracked as "HomeViewController" by the SDK swizzle.
/// Uses UXRate.setScreen("Home") to override with a cleaner name.
class HomeViewController: UITableViewController {

    private let sections = [
        ("Browse", [
            ("Products", "bag.fill"),
            ("Orders", "shippingbox.fill"),
            ("Notifications (SwiftUI)", "bell.fill"),
        ]),
        ("Status", [
            ("Survey button visible", "checkmark.circle.fill"),
        ]),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UXRate.setScreen("Home")
        UXRate.track(event: "screen_viewed", properties: ["screen": "Home"])
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int { sections.count }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section].0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].1.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = sections[indexPath.section].1[indexPath.row]
        var config = cell.defaultContentConfiguration()
        config.text = item.0
        config.image = UIImage(systemName: item.1)

        if indexPath.section == 0 {
            cell.accessoryType = .disclosureIndicator
        } else {
            cell.accessoryType = .none
            config.imageProperties.tintColor = .systemGreen
        }

        cell.contentConfiguration = config
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard indexPath.section == 0 else { return }

        let vc: UIViewController
        switch indexPath.row {
        case 0:
            vc = ProductsViewController()
        case 1:
            vc = OrdersViewController()
        case 2:
            // Push a SwiftUI view via UIHostingController — demonstrates hybrid auto-detection
            vc = NotificationsHostingController()
        default:
            return
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}
