//
//  MyTextEditor.swift
//  Vollmed
//
//  Created by daniel.ancines on 12/05/25.
//

import SwiftUI

enum MyTextEditorType{
    case normal
    case secure
}

struct MyTextEditor: View {
    @State private var email = ""
    @State private var password = ""
    
    public let type: MyTextEditorType
    public let text: String
    
    var body: some View {
        switch type {
        case .normal:
            TextField(self.text, text: $email)
                .padding(14)
                .background(Color.gray.opacity(0.25))
                .cornerRadius(14)
                .autocorrectionDisabled()
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
        case .secure:
            SecureField(self.text, text: $password)
                .padding(14)
                .background(Color.gray.opacity(0.25))
                .cornerRadius(14)
        }
    }
}

#Preview {
    MyTextEditor(type: .normal, text: "Text")
}
