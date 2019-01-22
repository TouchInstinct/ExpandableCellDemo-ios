import TableKit

class AutoLayoutViewController: BaseViewController {

    override var layoutType: String {
        return "Auto Layout"
    }

    override func rows(width: CGFloat) -> [Row] {
        return Array(0...100)
            .map {
                TableRow<ExpandableAutolayoutCell>(item: BaseExpandableCellViewModel(index: $0, width: width))
        }
    }

}
