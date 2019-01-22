import TableKit

final class ExpandableManualLayoutCell: BaseTableViewCell, ConfigurableCell, Expandable {

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

        collapsedView.frame = CGRect(x: 0,
                                     y: 0,
                                     width: viewModel.width,
                                     height: BaseTableViewCell.collapsedHeight)

        indexLabel.frame = CGRect(x: 0,
                                  y: 0,
                                  width: viewModel.width,
                                  height: 0)
        indexLabel.sizeToFit()

        label.frame = CGRect(x: BaseTableViewCell.textMargin,
                             y: collapsedView.frame.maxY + BaseTableViewCell.textMargin,
                             width: viewModel.width - BaseTableViewCell.textMargin * 2,
                             height: 0)
        label.sizeToFit()
    }

    // MARK: - Expandable

    func configure(state: ExpandableState) {
        guard let viewModel = viewModel else {
            return
        }

        let height = state.isCollapsed
            ? BaseTableViewCell.collapsedHeight
            : state.height ?? (label.frame.maxY + BaseTableViewCell.bottomMargin)
        
        containerView.frame = CGRect(x: 0, y: 0, width: viewModel.width, height: height)

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
