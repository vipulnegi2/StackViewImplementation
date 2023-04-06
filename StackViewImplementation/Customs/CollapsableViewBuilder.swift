//
//  CollapsableViewBuilder.swift
//  StackViewImplementation
//
//  Created by Vipul Negi on 06/04/23.
//

import SwiftUI

@resultBuilder
struct CollapsableViewBuilder {
    static func buildBlock(_ components: CollapsableView...) -> TupleView<[CollapsableView]> {
        TupleView(components)
    }
}

