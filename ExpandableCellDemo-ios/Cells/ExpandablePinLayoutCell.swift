import TableKit
import PinLayout

final class ExpandablePinLayoutCell: BaseTableViewCell, ConfigurableCell, Expandable {
    
    // MARK: - Init

    override func initializeView() {
        super.initializeView()
        
        collapsedView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(expand)))
    }

    // MARK: - Actions

    @objc func expand() {
        toggleState()
    }

    // MARK: - Overrides

    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let viewModel = viewModel else {
            return
        }
        
        containerView.pin
            .top()
            .horizontally()
            .width(viewModel.width)
        
        collapsedView.pin
            .top()
            .left()
            .right()
            .height(BaseTableViewCell.collapsedHeight)
        
        label.pin
            .below(of: collapsedView)
            .marginTop(BaseTableViewCell.textMargin)
            .left(BaseTableViewCell.textMargin)
            .right(BaseTableViewCell.textMargin)
            .sizeToFit(.width)

        indexLabel.pin
            .left()
            .top()
            .sizeToFit()
    }

    // MARK: - Expandable

    func configure(state: ExpandableState) {
        guard let viewModel = viewModel else {
            return
        }
        
        let height = state.isCollapsed
            ? BaseTableViewCell.collapsedHeight
            : state.height ?? (label.frame.maxY + BaseTableViewCell.bottomMargin)
        
        containerView.pin.height(height)
        
        containerView.backgroundColor = state.isCollapsed ? viewModel.collapsedColor : .random()

        label.alpha = state.isCollapsed ? 0 : 1
    }

    // MARK: - ConfigurableCell

    func configure(with viewModel: BaseExpandableCellViewModel) {
        self.viewModel = viewModel

        label.text = viewModel.text

        indexLabel.text = String(viewModel.index)

        initState()
    }

    static var layoutType: LayoutType {
        return .manual
    }

}
