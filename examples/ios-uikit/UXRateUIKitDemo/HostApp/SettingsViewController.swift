import UIKit
import UXRateSDK

/// Pure UIKit settings screen — auto-tracked as "SettingsViewController" by the SDK swizzle.
class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        view.backgroundColor = .systemBackground

        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false

        let icon = UIImageView(image: UIImage(systemName: "gearshape.fill"))
        icon.tintColor = .systemGray
        icon.contentMode = .scaleAspectFit
        icon.preferredSymbolConfiguration = .init(pointSize: 60)

        let titleLabel = UILabel()
        titleLabel.text = "Settings Screen"
        titleLabel.font = .preferredFont(forTextStyle: .title1)

        let subtitleLabel = UILabel()
        subtitleLabel.text = "Pure UIKit view controller.\nAuto-tracked as \"SettingsViewController\"."
        subtitleLabel.font = .preferredFont(forTextStyle: .subheadline)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0

        stack.addArrangedSubview(icon)
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(subtitleLabel)

        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 32),
        ])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UXRate.track(event: "screen_viewed", properties: ["screen": "Settings"])
    }
}
