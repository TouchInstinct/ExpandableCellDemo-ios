import SnapKit

class MainViewController: UIViewController {

    // MARK: - Views

    private let autoButton = UIButton(type: .system)

    private let pinButton = UIButton(type: .system)

    private let manualButton = UIButton(type: .system)

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        view.addSubview(autoButton)
        view.addSubview(pinButton)
        view.addSubview(manualButton)

        makeAutoButtonConstraints()
        makePinButtonConstraints()
        makeManualButtonConstraints()

        autoButton.setTitle("Auto Layout", for: .normal)
        pinButton.setTitle("Pin Layout", for: .normal)
        manualButton.setTitle("Manual Layout", for: .normal)

        autoButton.addTarget(self, action: #selector(auto), for: .touchUpInside)
        pinButton.addTarget(self, action: #selector(pin), for: .touchUpInside)
        manualButton.addTarget(self, action: #selector(manual), for: .touchUpInside)
    }

    // MARK: - Actions

    @objc func auto() {
        navigationController?.pushViewController(AutoLayoutViewController(), animated: true)
    }

    @objc func pin() {
        navigationController?.pushViewController(PinLayoutViewController(), animated: true)
    }

    @objc func manual() {
        navigationController?.pushViewController(ManualLayoutViewController(), animated: true)
    }

}

// MARK: - Constraints

private extension MainViewController {

    func makeAutoButtonConstraints() {
        autoButton.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(50)
        }
    }

    func makePinButtonConstraints() {
        pinButton.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(autoButton.snp.bottom).offset(50)
        }
    }

    func makeManualButtonConstraints() {
        manualButton.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(pinButton.snp.bottom).offset(50)
        }
    }

}
