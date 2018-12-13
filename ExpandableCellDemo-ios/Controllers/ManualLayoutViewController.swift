import TableKit

class ManualLayoutViewController: BaseViewController {

    override var layoutType: String {
        return "Manual Layout"
    }

    override var rows: [Row] {
        return Array(0...100)
            .map {
                TableRow<ExpandableManualLayoutCell>(item: BaseExpandableCellViewModel(index: $0))
        }
    }

}
