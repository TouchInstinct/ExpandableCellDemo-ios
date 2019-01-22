import TableKit

class BaseExpandableCellViewModel: ExpandableCellViewModel {

    // MARK: - Properties
    
    let index: Int
    
    let width: CGFloat

    let text: String = .random(length: .random(in: 100...400))

    // MARK: - Colors

    let collapsedColor = UIColor.random()

    // MARK: - ExpandableCellViewModel

    var expandableState: ExpandableState = .expanded
    
    static let oneLineState: ExpandableState = .height(value: BaseTableViewCell.collapsedHeight + 40)
    
    static let twoLinesState: ExpandableState = .height(value: BaseTableViewCell.collapsedHeight + 60)
    
    static let threeLinesState: ExpandableState = .height(value: BaseTableViewCell.collapsedHeight + 80)

    var availableStates: [ExpandableState] = [
        .collapsed,
        oneLineState,
        twoLinesState,
        threeLinesState,
        .expanded
    ]
    
    // MARK: - Life Cycle

    init(index: Int,
         width: CGFloat) {
        self.index = index
        self.width = width
    }

}
