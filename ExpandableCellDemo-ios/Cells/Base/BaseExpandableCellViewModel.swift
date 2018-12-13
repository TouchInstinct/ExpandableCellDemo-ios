import TableKit

class BaseExpandableCellViewModel: ExpandableCellViewModel {

    // MARK: - Properties

    let index: Int

    let text: String = .random(length: .random(in: 50...400))

    // MARK: - Colors

    let collapsedColor = UIColor.random()

    let expandedColor = UIColor.random()

    // MARK: - ExpandableCellViewModel

    var isCollapsed = true

    // MARK: - Life Cycle

    init(index: Int) {
        self.index = index
    }

}
