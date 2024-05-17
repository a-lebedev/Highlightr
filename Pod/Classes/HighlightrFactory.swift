//
//  HighlightrFactory.swift
//  
//
//  Created by Andrew Lebedev on 17.05.24.
//

import Foundation
import JavaScriptCore

public final class HighlightrFactory {
  private let hgJs: String?
  private let bundle : Bundle

  public init(highlightPath: String? = nil) {
    #if SWIFT_PACKAGE
    let bundle = Bundle.module
    #else
    let bundle = Bundle(for: Highlightr.self)
    #endif
    self.bundle = bundle
    if let hgPath = highlightPath ?? bundle.path(forResource: "highlight.min", ofType: "js") {
      let hgJs = try! String.init(contentsOfFile: hgPath)
      self.hgJs = hgJs
    } else {
      self.hgJs = nil
    }
  }

  public func makeParser(themeName: String = "tomorrow-night") -> Highlightr? {
    guard let hgJs else { return nil }
    let handle = Highlightr(hgJs: hgJs, bundle: bundle, themeName: themeName)
    return handle
  }
}
