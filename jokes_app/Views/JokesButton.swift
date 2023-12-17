//
//  JokesButton.swift
//  jokes_app
//
//  Created by Vilius Bundulas on 17/12/2023.
//

import SwiftUI

struct JokesButton: View {
    
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(title)
                .font(.footnote)
                .foregroundStyle(.white)
                .bold()
                .padding(.vertical, 22)
                .frame(maxWidth: .infinity, alignment: .center)
                .background(
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .fill(Color(red: 31 / 255, green: 31 / 255, blue: 31 / 255))
                )
        })
    }
}
