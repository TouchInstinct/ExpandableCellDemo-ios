import TableKit

class BaseTableViewCell: UITableViewCell {

    // MARK: - Constants

    static let collapsedHeight: CGFloat = 60

    static let textMargin: CGFloat = 20

    static let bottomMargin: CGFloat = 40

    // MARK: - Views

    let containerView = UIView()

    let collapsedView = UIView()

    let label = UILabel()

    let indexLabel = UILabel()

    // MARK: - Properties

    weak var viewModel: BaseExpandableCellViewModel?

    // MARK: - Life Cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        clipsToBounds = true

        label.numberOfLines = 0

        collapsedView.addSubview(indexLabel)
        containerView.addSubview(collapsedView)
        containerView.addSubview(label)
        contentView.addSubview(containerView)

        initializeView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        label.preferredMaxLayoutWidth = contentView.frame.width - 2 * BaseTableViewCell.textMargin
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - To Override

    func initializeView() {

    }

}
