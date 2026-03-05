import UIKit
import UXRateSDK

/// Pure UIKit products screen — uses UXRate.setScreen("Products") to override
/// the auto-detected "ProductsViewController" class name.
class ProductsViewController: UITableViewController {

    private let products: [(String, String, String)] = [
        ("MacBook Pro", "laptop", "$1,999"),
        ("iPhone 17 Pro", "iphone", "$1,199"),
        ("AirPods Pro", "airpodspro", "$249"),
        ("Apple Watch", "applewatch", "$399"),
        ("iPad Air", "ipad", "$599"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Products"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UXRate.setScreen("Products")
    }

    // MARK: - Table View

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let product = products[indexPath.row]

        var config = cell.defaultContentConfiguration()
        config.text = product.0
        config.secondaryText = product.2
        config.image = UIImage(systemName: product.1)
        config.imageProperties.tintColor = .systemBlue
        cell.contentConfiguration = config

        return cell
    }
}
