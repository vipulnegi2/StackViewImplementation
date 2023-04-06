//
//  CollapsableViewModel.swift
//  StackViewImplementation
//
//  Created by Vipul Negi on 06/04/23.
//

import SwiftUI

class CollapsableViewModel: ObservableObject {
    @Published var model: CollapsableModel = CollapsableModel()
    
    func isCollapsed() -> Bool {
        self.model.collapsed
    }
    
    func isExpanded() -> Bool {
        !self.model.collapsed
    }
    
    func collapse() {
        self.model.collapsed = true
    }
    
    func expand() {
        self.model.collapsed = false
    }
    
    func getID() -> UUID {
        self.model.id
    }
}
