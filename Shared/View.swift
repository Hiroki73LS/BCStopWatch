//
//  View.swift
//  BigLapTimer (iOS)
//
//  Created by 林宏樹 on 2022/01/22.
//

import SwiftUI

struct TextView: View {
    
    var label : String
    
    var body: some View {
        Text(label)
            .font(.title)
            .frame(width: 140, height: 120, alignment: .center)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color("ColorButton"), lineWidth: 5)
            )
            .foregroundColor(Color("Colormoji2"))
    }
}

struct TextView2: View {
    
    var label : String
    
    var body: some View {
        Text(label)
            .font(.title)
            .frame(width: 140, height: 120, alignment: .center)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.blue, lineWidth: 5)
            )
            .foregroundColor(Color("Colormoji3"))
            .background(Color(.blue))
    }
}

struct TextView3: View {
    
    var label : String
    
    var body: some View {
        Text(label)
            .font(.title2)
            .frame(width: 110, height: 120, alignment: .center)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color("ColorButton"), lineWidth: 5)
            )
            .foregroundColor(Color("Colormoji2"))
    }
}

struct TextView4: View {
    
    var label : String
    
    var body: some View {
        Text(label)
            .font(.title2)
            .frame(width: 110, height: 120, alignment: .center)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.blue, lineWidth: 5)
            )
            .foregroundColor(Color("Colormoji3"))
            .background(Color(.blue))
    }
}


struct MyButtonStyle2: ButtonStyle {
  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
        .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
}
}

