#!/usr/bin/env xcrun --sdk macosx swift
import Foundation

enum Flavour: String {
    case flavour1 = "Flavour1"
    case flavour2 = "Flavour2"
    case flavour3 = "Flavour3"
    case none
    
    func path() -> String {
        var flavourFolderName = ""
        switch self {
        case .flavour1:
            flavourFolderName = "Flavour1"
        case .flavour2:
            flavourFolderName = "Flavour2"
        case .flavour3:
            flavourFolderName = "Flavour3"
        default:
            flavourFolderName = ""
        }
        
        return FileManager.default.currentDirectoryPath.appending("/BuildConfiguration/Configurations/\(flavourFolderName)")
    }
}

func fatalError(_ errorMessage: String) {
    print("ERROR - \(errorMessage)")
    exit(0)
}

func warning(_ warningMessage: String) {
    print("WARNING - \(warningMessage)")
}

func parseParameters() -> Flavour {
    
    var arguments = CommandLine.arguments
    
    guard arguments.count > 1 else {
        fatalError("Pass atleast one flavour name")
        return .none
    }
    
    guard arguments.count == 2 else {
        fatalError("Single flavour can be build at a time: Flavours:\(arguments)")
        return .none
    }
    
    let flavourName = arguments[1]
    if let flavour = Flavour(rawValue: flavourName) {
        return flavour
    } else {
        fatalError("Pass a valid flavour name")
        return .none
    }
}

func getPodXCConfigFiles() -> [URL] {
    
    var paths = [URL]()
    let fileManager = FileManager.default
    let rootPath = fileManager.currentDirectoryPath.appending("/Pods/Target Support Files/Pods-Application")
    do {
        let files = try fileManager.contentsOfDirectory(atPath: rootPath)

        for file in files where file.hasSuffix(".xcconfig") {
            paths.append(URL(fileURLWithPath: rootPath.appending(file)))
        }
    } catch {
        fatalError(error.localizedDescription)
    }

    return paths
}

let flavour = parseParameters()
let defaultPath = FileManager.default.currentDirectoryPath.appending("/BuildConfiguration/Flavour")
let podXCConfigFiles = getPodXCConfigFiles()
print("Flavour path: \(flavour.path()) defaultpath: \(defaultPath) xcconfig paths \(podXCConfigFiles)")
do {
    try FileManager.default.removeItem(atPath: defaultPath)
    try FileManager.default.copyItem(atPath: flavour.path(), toPath: defaultPath)
} catch let error {
    fatalError(error.localizedDescription)
}

print("done")
