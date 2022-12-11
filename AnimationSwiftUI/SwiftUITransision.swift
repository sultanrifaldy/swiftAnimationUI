//
//  SwiftUITransision.swift
//  AnimationSwiftUI
//
//  Created by Sultan Rifaldy on 09/12/22.
//

import SwiftUI

struct SwiftUITransision: View {
    //MARK: PROPERTIES
    @State private var isShowing : Bool = false
    @State private var notUse : Bool = false
    @State private var anotherNotUse : Bool = false
    
    //MARK: BODY
    var body: some View {
        VStack{
            if isShowing {
                Image("yoasobi_detail")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                    .cornerRadius(10)
                    .transition(.scale(scale: 0, anchor: .bottom))
            } else {
                Image("yoasobi_view")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                    .cornerRadius(10)
                    .transition(.scale(scale: 0, anchor: .bottom))
            }
            
        } //: VSTACK
        .onTapGesture {
            withAnimation(Animation.spring()) {
                isShowing.toggle()
            }
        }
    }
}

struct SwiftUITransision_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUITransision()
    }
}
