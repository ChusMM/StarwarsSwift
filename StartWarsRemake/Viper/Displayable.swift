//
//  Displayable.swift
//  StartWarsRemake
//
//  Created by Muñoz, Jesus Manuel on 14/3/21.
//

import Foundation

protocol Displayable {
  var titleLabelText: String { get }
  var subtitleLabelText: String { get }
  var item1: (label: String, value: String) { get }
  var item2: (label: String, value: String) { get }
  var item3: (label: String, value: String) { get }
  var listTitle: String { get }
  var listItems: [String] { get }
}
