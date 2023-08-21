//
//  CustomStackView.swift
//  KlarnaTest
//
//  Created by Taranjeet Kaur on 21/07/23.
//

import SwiftUI

struct CustomStackView<Title: View, Content: View>: View {
    var titleView: Title
    var contentView: Content
    
    init(@ViewBuilder titleView: @escaping ()-> Title, @ViewBuilder contentView: @escaping ()-> Content) {
        
        self.titleView = titleView()
        self.contentView = contentView()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            titleView
                .font(.callout)
                .lineLimit(1)
                .frame(height: 38)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .background(.ultraThinMaterial, in: CustomCorner(corners: [.topLeft,.topRight], radius: 12))
            
            VStack{
                Divider()
                contentView
                    .padding()
            }
            
            .background(.ultraThinMaterial, in: CustomCorner(corners: [.bottomLeft,.bottomRight ], radius: 12))
        }
        .colorScheme(.dark)
        
    }
}

struct CustomCorner: Shape {
    
    var corners: UIRectCorner
    var radius:  CGFloat
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


struct CustomStackView_Previews: PreviewProvider {
    static var previews: some View {
        Home(locationManager: LocationManager())
    }
}
