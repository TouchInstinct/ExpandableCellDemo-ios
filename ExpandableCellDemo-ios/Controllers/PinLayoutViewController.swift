import TableKit

class PinLayoutViewController: BaseViewController {

    override var layoutType: String {
        return "Pin Layout"
    }

    override func rows(width: CGFloat) -> [Row] {
        return Array(0...100)
            .map {
                TableRow<ExpandablePinLayoutCell>(item: BaseExpandableCellViewModel(index: $0, width: width))
        }
    }

}
