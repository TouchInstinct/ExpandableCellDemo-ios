import TableKit

extension TableDirector {

    func replace(withSections sections: [TableSection]) {
        clear().append(sections: sections).reload()
    }

}
