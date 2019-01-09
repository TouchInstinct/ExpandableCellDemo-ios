import TableKit
import PinLayout

final class ExpandablePinLayoutCell: BaseTableViewCell, ConfigurableCell, Expandable {

    // MARK: - Init

    override func initializeView() {
        collapsedView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(expand)))
    }

    // MARK: - Actions

    @objc func expand() {
        toggleState()
    }

    // MARK: - Overrides

    override func layoutSubviews() {
        super.layoutSubviews()

        indexLabel.pin
            .left()
            .top()
            .sizeToFit()

        label.pin
            .below(of: collapsedView)
            .marginTop(BaseTableViewCell.textMargin)
            .left(BaseTableViewCell.textMargin)
            .right(BaseTableViewCell.textMargin)
            .sizeToFit(.width)

        collapsedView.pin
            .top()
            .left()
            .right()
            .height(BaseTableViewCell.collapsedHeight)
    }

    // MARK: - Expandable

    func configureAppearance(isCollapsed: Bool) {
        guard let viewModel = viewModel else {
            return
        }

        containerView.pin
            .top()
            .left()
            .right()
            .height(isCollapsed ? BaseTableViewCell.collapsedHeight : (label.frame.maxY + BaseTableViewCell.bottomMargin))

        containerView.backgroundColor = isCollapsed ? viewModel.collapsedColor : viewModel.expandedColor

        label.alpha = isCollapsed ? 0 : 1
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
