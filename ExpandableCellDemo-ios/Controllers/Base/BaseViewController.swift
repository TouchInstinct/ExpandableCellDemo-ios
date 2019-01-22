import SnapKit
import TableKit

class BaseViewController: UIViewController {

    // MARK: - Views

    private let tableView = UITableView()

    // MARK: - Properties

    var layoutType: String {
        return ""
    }

    func rows(width: CGFloat) -> [Row] {
        return []
    }

    private lazy var tableDirector = TableDirector(tableView: tableView,
                                                   cellHeightCalculator: ExpandableCellHeightCalculator(tableView: tableView))

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        makeTableViewConstraints()
        view.backgroundColor = .white
        tableView.separatorStyle = .none
        navigationItem.title = layoutType

        let width = view.frame.width
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.loadRows(width: width)
        }
    }

    func loadRows(width: CGFloat) {
        let section = TableSection(onlyRows: rows(width: width))

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
