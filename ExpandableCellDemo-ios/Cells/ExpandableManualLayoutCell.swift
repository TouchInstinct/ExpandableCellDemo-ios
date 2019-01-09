import TableKit

final class ExpandableManualLayoutCell: BaseTableViewCell, ConfigurableCell, Expandable {

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

        collapsedView.frame = CGRect(x: 0,
                                     y: 0,
                                     width: UIScreen.main.bounds.width,
                                     height: BaseTableViewCell.collapsedHeight)

        indexLabel.frame = CGRect(x: 0,
                                  y: 0,
                                  width: UIScreen.main.bounds.width,
                                  height: 0)
        indexLabel.sizeToFit()

        label.frame = CGRect(x: BaseTableViewCell.textMargin,
                             y: collapsedView.frame.maxY + BaseTableViewCell.textMargin,
                             width: UIScreen.main.bounds.width - BaseTableViewCell.textMargin * 2,
                             height: 0)
        label.sizeToFit()
    }

    // MARK: - Expandable

    func configureAppearance(isCollapsed: Bool) {
        guard let viewModel = viewModel else {
            return
        }

        containerView.frame = CGRect(x: 0,
                                     y: 0,
                                     width: UIScreen.main.bounds.width,
                                     height: isCollapsed ? BaseTableViewCell.collapsedHeight : (label.frame.maxY + BaseTableViewCell.bottomMargin))

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
