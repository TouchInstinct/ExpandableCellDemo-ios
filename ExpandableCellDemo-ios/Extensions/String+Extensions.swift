import Foundation

extension String {

    static func random(length: Int) -> String {

        var text = ""

        for _ in 1...length {
            // ascii decimal value of a character
            let decValue = Int(arc4random_uniform(26)) + 97

            // get ASCII character from random decimal value
            if let scalar = UnicodeScalar(decValue) {
                text = text + String(scalar)
            }

            // remove double spaces
            text = text.replacingOccurrences(of: "  ", with: " ")
        }

        return text
    }

}
