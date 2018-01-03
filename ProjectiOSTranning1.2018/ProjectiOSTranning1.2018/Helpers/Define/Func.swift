//
//  Func.swift
//  ProjectiOSTranning1.2018
//
//  Created by TuyenVX on 1/3/18.
//  Copyright © 2018 TuyenVX. All rights reserved.
//

import Foundation

public func logD(_ object: Any?, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
    #if !NDEBUG
        let classNameWithExention = (fileName as NSString).deletingPathExtension
        let className = (classNameWithExention as NSString).lastPathComponent
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let date = formatter.string(from: NSDate() as Date)
        print("⚠️ \(date) \(className) - \(functionName) (#\(lineNumber)): \n\(object ?? "nil")\n")
    #endif
}
