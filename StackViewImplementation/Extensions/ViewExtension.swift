//
//  ViewExtension.swift
//  StackViewImplementation
//
//  Created by Vipul Negi on 06/04/23.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
