//
//  CountOnMeModel.swift
//  CountOnMe
//
//  Created by noje on 30/06/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

var elements: [String] {
    return textView.text.split(separator: " ").map { "\($0)" }
}

// Error check computed variables
var expressionIsCorrect: Bool {
    return elements.last != "+" && elements.last != "-"
}

var expressionHaveEnoughElement: Bool {
    return elements.count >= 3
}

var canAddOperator: Bool {
    return elements.last != "+" && elements.last != "-" && elements.last != "*" && elements.last != "/"
}


var expressionHaveResult: Bool {
    return textView.text.firstIndex(of: "=") != nil
}


