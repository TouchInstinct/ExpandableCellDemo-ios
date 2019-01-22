import SnapKit
import TableKit

private extension CGFloat {
    
    static let spaceBetweenStateButtons: CGFloat = 10
    
}

final class ExpandableAutolayoutCell: BaseTableViewCell, ConfigurableCell, Expandable {

    // MARK: - Init

    override func initializeView() {
        super.initializeView()
        
        collapsedView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(expand)))
        
        collapsedStateButton.addTarget(self, action: #selector(toCollapsed), for: .touchUpInside)
        oneLineButton.addTarget(self, action: #selector(toOneLine), for: .touchUpInside)
        twoLinesButton.addTarget(self, action: #selector(toTwoLines), for: .touchUpInside)
        threeLinesButton.addTarget(self, action: #selector(toThreeLines), for: .touchUpInside)
        expandedStateButton.addTarget(self, action: #selector(toExpanded), for: .touchUpInside)
        makeConstraints()
    }
    
    @objc func toCollapsed() {
        transition(to: .collapsed)
    }
    
    @objc func toOneLine() {
        transition(to: BaseExpandableCellViewModel.oneLineState)
    }
    
    @objc func toTwoLines() {
        transition(to: BaseExpandableCellViewModel.twoLinesState)
    }
    
    @objc func toThreeLines() {
        transition(to: BaseExpandableCellViewModel.threeLinesState)
    }
    
    @objc func toExpanded() {
        transition(to: .expanded)
    }

    // MARK: - Actions

    @objc func expand() {
        toggleState()
    }

    // MARK: - Properties

    private var heightConstraint: Constraint?

    // MARK: - Expandable

    func configure(state: ExpandableState) {
        guard let viewModel = viewModel else {
            return
        }

        heightConstraint?.layoutConstraints.first?.constant = state.isCollapsed
            ? BaseTableViewCell.collapsedHeight
            : state.height ?? (label.frame.maxY + BaseTableViewCell.bottomMargin)

        containerView.backgroundColor = state.isCollapsed ? viewModel.collapsedColor : .random()

        label.alpha = state.isCollapsed ? 0 : 1
    }

    // MARK: - ConfigurableCell

    func configure(with viewModel: BaseExpandableCellViewModel) {
        self.viewModel = viewModel

        label.text = viewModel.text
        indexLabel.text = String(viewModel.index)
        
        label.preferredMaxLayoutWidth = viewModel.width - 2 * BaseTableViewCell.textMargin

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
        makeCollapsedStateButtonConstraints()
        makeOneLineButtonConstraints()
        makeTwoLinesButtonConstraints()
        makeThreeLinesButtonConstraints()
        makeExpandedStateButtonConstraints()
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
    
    func makeCollapsedStateButtonConstraints() {
        collapsedStateButton.snp.remakeConstraints { make in
            make.firstBaseline.equalTo(indexLabel.snp.firstBaseline)
            make.leading.equalTo(indexLabel.snp.trailing).offset(CGFloat.spaceBetweenStateButtons)
        }
    }
    
    func makeOneLineButtonConstraints() {
        oneLineButton.snp.remakeConstraints { make in
            make.firstBaseline.equalTo(indexLabel.snp.firstBaseline)
            make.leading.equalTo(collapsedStateButton.snp.trailing).offset(CGFloat.spaceBetweenStateButtons)
        }
    }
    
    func makeTwoLinesButtonConstraints() {
        twoLinesButton.snp.remakeConstraints { make in
            make.firstBaseline.equalTo(indexLabel.snp.firstBaseline)
            make.leading.equalTo(oneLineButton.snp.trailing).offset(CGFloat.spaceBetweenStateButtons)
        }
    }
    
    func makeThreeLinesButtonConstraints() {
        threeLinesButton.snp.remakeConstraints { make in
            make.firstBaseline.equalTo(indexLabel.snp.firstBaseline)
            make.leading.equalTo(twoLinesButton.snp.trailing).offset(CGFloat.spaceBetweenStateButtons)
        }
    }
    
    func makeExpandedStateButtonConstraints() {
        expandedStateButton.snp.remakeConstraints { make in
            make.firstBaseline.equalTo(indexLabel.snp.firstBaseline)
            make.leading.equalTo(threeLinesButton.snp.trailing).offset(CGFloat.spaceBetweenStateButtons)
        }
    }

}
