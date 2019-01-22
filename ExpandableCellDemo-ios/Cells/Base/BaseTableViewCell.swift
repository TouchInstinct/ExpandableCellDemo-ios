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
    
    let collapsedStateButton = UIButton()
    
    let oneLineButton = UIButton()
    
    let twoLinesButton = UIButton()
    
    let threeLinesButton = UIButton()
    
    let expandedStateButton = UIButton()

    // MARK: - Properties

    weak var viewModel: BaseExpandableCellViewModel?

    // MARK: - Life Cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        clipsToBounds = true

        label.numberOfLines = 0

        collapsedView.addSubview(indexLabel)
        collapsedView.addSubview(collapsedStateButton)
        collapsedView.addSubview(expandedStateButton)
        collapsedView.addSubview(oneLineButton)
        collapsedView.addSubview(twoLinesButton)
        collapsedView.addSubview(threeLinesButton)
        containerView.addSubview(collapsedView)
        containerView.addSubview(label)
        contentView.addSubview(containerView)

        initializeView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - To Override

    func initializeView() {
        collapsedStateButton.setTitle("Collapsed", for: .normal)
        oneLineButton.setTitle("One Line", for: .normal)
        twoLinesButton.setTitle("Two Lines", for: .normal)
        threeLinesButton.setTitle("Three Lines", for: .normal)
        expandedStateButton.setTitle("Expanded", for: .normal)
        
        [collapsedStateButton, oneLineButton, twoLinesButton, threeLinesButton, expandedStateButton]
            .forEach { button in
                button.setTitleColor(.black, for: .normal)
                button.titleLabel?.font = .systemFont(ofSize: 10)
            }
    }

}
