import SnapKit
import TableKit

class ExpandableAutolayoutCell: BaseTableViewCell, ConfigurableCell, Expandable {

    // MARK: - Init

    override func initializeView() {
        collapsedView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(expand)))
        makeConstraints()
    }

    // MARK: - Actions

    @objc func expand() {
        toggleState()
    }

    // MARK: - Properties

    private var heightConstraint: Constraint?

    // MARK: - Expandable

    func configureAppearance(isCollapsed: Bool) {
        guard let viewModel = viewModel else {
            return
        }

        heightConstraint?.layoutConstraints.first?.constant = isCollapsed
            ? BaseTableViewCell.collapsedHeight
            : label.frame.maxY + BaseTableViewCell.bottomMargin

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
        return .auto
    }

}

// MARK: - Constraints

private extension ExpandableAutolayoutCell {

    func makeConstraints() {
        makeContainerViewConstraints()
        makeCollapsedViewConstraints()
        makeLabelConstraints()
        makeIndexLabelConstraints()
    }

    func makeContainerViewConstraints() {
        containerView.snp.remakeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().priority(.low)
            heightConstraint = make.height.equalTo(0).constraint
        }
    }

    func makeCollapsedViewConstraints() {
        collapsedView.snp.remakeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(BaseTableViewCell.collapsedHeight)
        }
    }

    func makeLabelConstraints() {
        label.snp.remakeConstraints { make in
            make.top.equalTo(collapsedView.snp.bottom).offset(BaseTableViewCell.textMargin)
            make.leading.trailing.equalToSuperview().inset(BaseTableViewCell.textMargin)
        }
    }

    func makeIndexLabelConstraints() {
        indexLabel.snp.remakeConstraints { make in
            make.top.leading.equalToSuperview()
        }
    }

}
