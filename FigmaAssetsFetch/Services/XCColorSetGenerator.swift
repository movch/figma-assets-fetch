import Foundation

protocol XCColorSetGeneratorType {
    func save(
        colors: [ColorObjectModel],
        darkColors: [ColorObjectModel]?,
        at pathURL: URL
    )
}

class XCColorSetGenerator {}

extension XCColorSetGenerator: XCColorSetGeneratorType {
    public func save(
        colors: [ColorObjectModel],
        darkColors: [ColorObjectModel]?,
        at pathURL: URL
    ) {
        let colorSetURL: URL = pathURL.appendingPathComponent("Colors.xcassets")
        do
        {
            try FileManager.default.createDirectory(
                atPath: colorSetURL.path,
                withIntermediateDirectories: true,
                attributes: nil
            )
            
            let assetInfo = XCAssetInfo(
                author: "xcode",
                version: 1
            )
            
            let assetInfoURL = colorSetURL.appendingPathComponent("Contents.json")
            let assetInfoContent = String(
                data: try JSONEncoder().encode(assetInfo),
                encoding: .utf8
            )
            
            try assetInfoContent?.write(
                to: assetInfoURL,
                atomically: true,
                encoding: String.Encoding.utf8
            )
            
            for color in colors {
                let colorAssetURL = colorSetURL.appendingPathComponent("\(color.camelCaseName).colorset")
                
                try FileManager.default.createDirectory(
                    atPath: colorAssetURL.path,
                    withIntermediateDirectories: true,
                    attributes: nil
                )
                
                let assetColorInfoURL = colorAssetURL.appendingPathComponent("Contents.json")
                let colorInfo = XCColorSet.with(
                    color: color,
                    darkColor: darkColors?.first(where: { $0.name == color.name })
                )
                let assetColorInfoContent = String(
                    data: try JSONEncoder().encode(colorInfo),
                    encoding: .utf8
                )
                
                try assetColorInfoContent?.write(
                    to: assetColorInfoURL,
                    atomically: true,
                    encoding: String.Encoding.utf8
                )
            }
        }
        catch let error as NSError
        {
            print("Unable to generate color set: \(error.debugDescription)")
        }
    }
}
