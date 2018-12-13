import SnapKit
import TableKit

class BaseViewController: UIViewController {

    // MARK: - Views

    private let tableView = UITableView()

    // MARK: - Properties

    var layoutType: String {
        return ""
    }

    var rows: [Row] {
        return []
    }

    private lazy var tableDirector = TableDirector(tableView: tableView)

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        makeTableViewConstraints()
        view.backgroundColor = .white
        tableView.separatorStyle = .none
        navigationItem.title = layoutType

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.loadRows()
        }
    }

    func loadRows() {
        let section = TableSection(onlyRows: rows)

        DispatchQueue.main.async { [weak self] in
            self?.tableDirector.replace(withSections: [section])
        }
    }

    // MARK: - Constraints

    func makeTableViewConstraints() {
        tableView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
