//
//  islcinstalled.swift
//  lara
//
//  Created by ruter on 30.03.26.
//

import Foundation
import MachO

func islcinstalled() -> Bool {
    // print("\nloaded images:")

    var detected = false
    let count = _dyld_image_count()

    // print("image count: \(count)\n")

    for i in 0..<count {
        guard let cName = _dyld_get_image_name(i) else {
            continue
        }

        let name = String(cString: cName)
        let lower = name.lowercased()

        let match =
            lower.contains("tweakinjector.dylib") ||
            lower.contains("tweakloader.dylib")

        if match {
            // print("[\(i)] \(name) <- aha!")
            detected = true
        } else {
            // print("[\(i)] \(name)")
        }
    }

    globallogger.log("\nlivecontainer detected: \(detected ? "yeah" : "nah")")

    return detected
}
