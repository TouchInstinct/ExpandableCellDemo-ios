import TableKit

class PinLayoutViewController: BaseViewController {

    override var layoutType: String {
        return "Pin Layout"
    }

    override var rows: [Row] {
        return Array(0...100)
            .map {
                TableRow<ExpandablePinLayoutCell>(item: BaseExpandableCellViewModel(index: $0))
        }
    }

}
