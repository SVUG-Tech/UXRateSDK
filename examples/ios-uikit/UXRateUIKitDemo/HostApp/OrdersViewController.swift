import UIKit

/// Pure UIKit orders screen — auto-tracked as "OrdersViewController" by the SDK swizzle.
class OrdersViewController: UITableViewController {

    private let orders: [(String, String, String, UIColor)] = [
        ("#10421", "MacBook Pro", "Delivered", .systemGreen),
        ("#10398", "AirPods Pro", "Shipped", .systemBlue),
        ("#10375", "iPhone Case", "Processing", .systemOrange),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Orders"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    // MARK: - Table View

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        orders.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let order = orders[indexPath.row]

        var config = cell.defaultContentConfiguration()
        config.text = order.1
        config.secondaryText = order.0
        cell.contentConfiguration = config

        // Status badge
        let badge = UILabel()
        badge.text = order.2
        badge.font = .systemFont(ofSize: 12, weight: .semibold)
        badge.textColor = order.3
        badge.backgroundColor = order.3.withAlphaComponent(0.15)
        badge.textAlignment = .center
        badge.layer.cornerRadius = 10
        badge.clipsToBounds = true
        badge.sizeToFit()
        badge.frame.size = CGSize(width: badge.frame.width + 16, height: 24)
        cell.accessoryView = badge

        return cell
    }
}
