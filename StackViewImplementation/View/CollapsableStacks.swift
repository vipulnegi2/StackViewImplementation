//
//  CollapsableStacks.swift
//  StackViewImplementation
//
//  Created by Vipul Negi on 06/04/23.
//

import SwiftUI

struct CollapsableStack: View {
    var showStackView: Binding<Bool>
    var collapsableViews: [CollapsableView]
    var numberOfCollapsableViews: Int
    
    @State var indexOfTheOneAndOnlyExpandedView: Int = 0
    @State var showDone = false
    @State var color: Color = .pink
    
    private let radius: CGFloat = 20
    private let verticalSpacing: CGFloat = -20
    private let nextButtonHeight: CGFloat = UIScreen.main.bounds.height * 0.1
    private let sheetHeight: CGFloat = UIScreen.main.bounds.height * 0.6
    private let collapsedHeight: CGFloat = UIScreen.main.bounds.height * 0.15
    
    
    init<Views>(showStackView: Binding<Bool>, @CollapsableViewBuilder content: @escaping () -> TupleView<Views>) {
        self.showStackView = showStackView
        self.collapsableViews = content().getViews
        self.numberOfCollapsableViews = self.collapsableViews.count
    }
    
    var body: some View {
        VStack(spacing: verticalSpacing) {
            if !showDone {
                Spacer()
                ForEach(0..<(indexOfTheOneAndOnlyExpandedView), id: \.self) { index in
                    collapsableViews[index].collpasedColor
                        .frame(height: collapsedHeight)
                        .overlay(alignment: .center) {
                            HStack {
                                Spacer()
                                Text(collapsableViews[index].collapsed.wrappedValue)
                                    .font(Font.largeTitle)
                                    .foregroundColor(.white)
                                Spacer()
                            }
                        }
                        .cornerRadius(radius, corners: [.topRight, .topLeft])
                        .onTapGesture {
                            collapsableViews[index].expand()
                            collapseOtherViews(except: index)
                            if index >= 0 {
                                withAnimation {
                                    indexOfTheOneAndOnlyExpandedView = index
                                }
                            }
                        }
                        .transition(.move(edge: .bottom))
                }
                
                VStack {
                    
                    collapsableViews[indexOfTheOneAndOnlyExpandedView].expanded
                        .onChange(of: indexOfTheOneAndOnlyExpandedView, perform: { newValue in
                            color = ((indexOfTheOneAndOnlyExpandedView % 2) == 0) ? .pink : .black
                        })
                    Spacer()
                    HStack {
                        Spacer()
                        if indexOfTheOneAndOnlyExpandedView < self.numberOfCollapsableViews - 1 {
                            Text(collapsableViews[indexOfTheOneAndOnlyExpandedView + 1].buttonText)
                            Spacer()
                            if !collapsableViews[indexOfTheOneAndOnlyExpandedView].collapsed.wrappedValue.isEmpty {
                                Image(systemName: "chevron.up")
                                    .font(.title2)
                                    .padding(.horizontal)
                                    .animation(.linear, value: collapsableViews[indexOfTheOneAndOnlyExpandedView].collapsed.wrappedValue)
                            }
                        }
                    }
                    .frame(height: nextButtonHeight)
                    .background(content: {
                        (indexOfTheOneAndOnlyExpandedView < self.numberOfCollapsableViews - 1) ? collapsableViews[indexOfTheOneAndOnlyExpandedView].collapsed.wrappedValue.isEmpty ? Color.black.opacity(0.5) : Color.white.opacity(0.5) : .clear
                    })
                    .cornerRadius(radius, corners: [.topRight, .topLeft])
                    .onTapGesture {
                        if indexOfTheOneAndOnlyExpandedView < self.numberOfCollapsableViews - 1 && !collapsableViews[indexOfTheOneAndOnlyExpandedView].collapsed.wrappedValue.isEmpty {
                            if let tappedView = self.collapsableViews.first(where: { $0.getID() == collapsableViews[indexOfTheOneAndOnlyExpandedView].getID() }) {
                                tappedView.collapse()
                            }
                            
                            collapsableViews[indexOfTheOneAndOnlyExpandedView+1].expand()
                            withAnimation {
                                indexOfTheOneAndOnlyExpandedView += 1
                            }
                            collapseOtherViews(except: indexOfTheOneAndOnlyExpandedView)
                        }
                    }
                }
                .frame(height: sheetHeight)
                .background {
                    color
                }
                .cornerRadius(radius, corners: [.topRight, .topLeft])
            } else {
                Color.pink
                    .edgesIgnoringSafeArea(.all)
                    .overlay(alignment: .center) {
                        Button {
                            showStackView.wrappedValue.toggle()
                        } label: {
                            Text("CLOSE")
                                .font(Font.headline)
                                .frame(width: UIScreen.main.bounds.width * 0.6, height: 50)
                                .background {
                                    Color.black
                                }
                                .cornerRadius(20)
                                .foregroundColor(.white)
                        }
                    }
                    .transition(.move(edge: .bottom))
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear() {
            withAnimation {
                collapseAllECViews()
            }
            withAnimation {
                expandFirstECView()
            }
        }
        .onDisappear() {
            withAnimation {
                collapseAllECViews()
            }
        }
    }
    
    //MARK:- Helper Functions
    
    private func collapseOtherViews(except index: Int) {
        for i in 0..<self.numberOfCollapsableViews {
            if i != index {
                withAnimation {
                    self.collapsableViews[i].collapse()
                }
            }
        }
    }
    
    private func expandFirstECView() {
        withAnimation {
            self.collapsableViews[0].expand()
        }
    }
    
    private func collapseAllECViews() {
        for i in 0..<self.numberOfCollapsableViews {
            withAnimation {
                self.collapsableViews[i].collapse()
            }
        }
    }
}

struct StackssView_Previews: PreviewProvider {
    static var previews: some View {
        StacksView()
    }
}
