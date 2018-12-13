import TableKit

class AutoLayoutViewController: BaseViewController {

    override var layoutType: String {
        return "Auto Layout"
    }

    override var rows: [Row] {
        return Array(0...100)
            .map {
                TableRow<ExpandableAutolayoutCell>(item: BaseExpandableCellViewModel(index: $0))
        }
    }

}
