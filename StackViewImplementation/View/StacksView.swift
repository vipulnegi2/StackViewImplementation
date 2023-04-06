//
//  ContentView.swift
//  StackViewImplementation
//
//  Created by Vipul Negi on 03/04/23.
//

import SwiftUI

struct StacksView: View {
    
    @State var showStackView: Bool = false
    @State var name: String = ""
    @State var contact: String = ""
    @State var email: String = ""
    
    var body: some View {
        ZStack {
            Button {
                withAnimation {
                    showStackView.toggle()
                }
            } label: {
                Text("Enter the Details")
                    .font(Font.headline)
                    .frame(width: UIScreen.main.bounds.width * 0.6, height: 70)
                    .background {
                        Color.pink
                    }
                    .cornerRadius(20)
                    .foregroundColor(.white)
            }
            
            .opacity(showStackView ? 0 : 1)
            
            if showStackView {
                CollapsableStack(showStackView: $showStackView) {
                    CollapsableView(expanded: AnyView(
                        VStack {
                            Text("Name: \(name)")
                                .padding()
                                .foregroundColor(.black)
                                .font(Font.headline)
                            TextField("Name", text: $name)
                                .padding()
                                .foregroundColor(.black)
                                .frame(width: UIScreen.main.bounds.width * 0.6, height: 50)
                                .background {
                                    Color.white.opacity(0.5)
                                }
                                .cornerRadius(20)
                                .padding()
                        }
                    ), collapsed: $name, buttonText: "Name", collapsedColor: .pink)
                    
                    CollapsableView(expanded: AnyView(
                        VStack {
                            Text("Contact: \(contact)")
                                .padding()
                                .foregroundColor(.white)
                                .font(Font.headline)
                            TextField("Contact", text: $contact)
                                .padding()
                                .foregroundColor(.black)
                                .frame(width: UIScreen.main.bounds.width * 0.6, height: 50)
                                .background {
                                    Color.white.opacity(0.5)
                                }
                                .cornerRadius(20)
                                .padding()
                        }
                    ), collapsed: $contact, buttonText: "Contact", collapsedColor: .black)
                    
                    CollapsableView(expanded: AnyView(
                        VStack {
                            Text("Email: \(email)")
                                .padding()
                                .foregroundColor(.black)
                                .font(Font.headline)
                            TextField("Email", text: $email)
                                .padding()
                                .foregroundColor(.white)
                                .frame(width: UIScreen.main.bounds.width * 0.6, height: 50)
                                .background {
                                    Color.white.opacity(0.5)
                                }
                                .cornerRadius(20)
                                .padding()
                        }
                    ), collapsed: $email, buttonText: "Email", collapsedColor: .pink)
                    
                    CollapsableView(expanded: AnyView(
                        VStack {
                            Button {
                                withAnimation {
                                    $showStackView.wrappedValue.toggle()
                                }
                            } label: {
                                Text("CLOSE")
                                    .font(Font.headline)
                                    .frame(width: UIScreen.main.bounds.width * 0.6, height: 50)
                                    .background {
                                        Color.pink
                                    }
                                    .cornerRadius(20)
                                    .foregroundColor(.white)
                                    .padding(.top, 200)
                            }
                        }
                    ), collapsed: $contact, buttonText: "Done", collapsedColor: .black)
                }
                .transition(.move(edge: .bottom))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color.black
        }
        .ignoresSafeArea()
    }
}

struct StacksView_Previews: PreviewProvider {
    static var previews: some View {
        StacksView()
    }
}

