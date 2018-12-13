import TableKit

public extension TableSection {

    convenience init(onlyRows rows: [Row]) {
        self.init(rows: rows)

        self.headerView = nil
        self.footerView = nil

        self.headerHeight = .leastNonzeroMagnitude
        self.footerHeight = .leastNonzeroMagnitude
    }

}
