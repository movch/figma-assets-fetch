import Foundation

extension String {
    var lowercasedFirstLetter: String {
        return prefix(1).lowercased() + dropFirst()
    }
    
    var capitalizedFirstLetter: String {
        return prefix(1).capitalized + dropFirst()
    }

    var stripped: String {
        let okayChars = Set("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890 ")
        return filter { okayChars.contains($0) }
    }
    
    var camelCased: String {
        return self
            .stripped
            .components(separatedBy: .whitespaces)
            .map({ $0.capitalizedFirstLetter })
            .joined()
            .lowercasedFirstLetter
    }

    var snakeCased: String {
        return self
            .stripped
            .components(separatedBy: .whitespaces)
            .filter { !$0.isEmpty }
            .map { $0.lowercasedFirstLetter  }
            .joined(separator: "_")
    }
}
