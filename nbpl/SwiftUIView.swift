//
//  SwiftUIView.swift
//  Nexdha's BNPL
//
//  Created by Nexdha on 27/05/22.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        Text("Hello, World!")
            .padding()
            .foregroundColor(.white)
            .font(.largeTitle)
            .background(
                LinearGradient(gradient: Gradient(colors: [.blue, .red, .black]), startPoint: .leading, endPoint: .trailing)
                
            )
        HStack {
          VStack {
            Rectangle()
            Text("Match this color")
                  .padding(20)
                  .font(.largeTitle)
          }
          VStack {
            HStack {
              Text("R: xxx")
              Text("G: xxx")
              Text("B: xxx")
              Text("R: xxx")
              Text("R: xxx")
              Text("R: xxx")

            }
          }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
       
    }
}
