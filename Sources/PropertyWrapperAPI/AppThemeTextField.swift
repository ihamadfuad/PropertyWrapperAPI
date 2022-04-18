
// ºººº----------------------------------------------------------------------ºººº \\
//
// Copyright (c) 2022 Hamad Fuad.
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
// associated documentation files (the "Software"), to deal in the Software without restriction,
// including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial
// portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
// NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
// THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
// Author: Hamad Fuad
// Email: ihamadfouad@icloud.com
//
// Created At: 18/04/2022
// Last modified: 18/04/2022
//
// ºººº----------------------------------------------------------------------ºººº \\

import SwiftUI

struct AppThemeTextField<RightBtnView: View>: View {

    var title: String = ""
    var placeholder: String = ""
    @Binding var textFieldText: String
    var textFieldHeight: CGFloat = 60
    var keyboardType: UIKeyboardType = .default

    var rightBtnView: RightBtnView
    @State private var moveTitleUp = false

    init(title: String = "",
         placeholder: String = "",
         textFieldText: Binding<String>,
         textFieldHeight: CGFloat = 60,
         keyboardType: UIKeyboardType = .default,
         @ViewBuilder rightBtnView: () -> RightBtnView) {
        self.title = title
        self.placeholder = placeholder
        self._textFieldText = textFieldText
        self.textFieldHeight = textFieldHeight
        self.keyboardType = keyboardType
        self.rightBtnView = rightBtnView()
    }

    var body: some View {

        ZStack(alignment: .leading) {

            HStack {
                TextField("", text: $textFieldText)
                    .keyboardType(keyboardType)
                    .onChange(of: textFieldText, perform: { _ in
                        if textFieldText.isEmpty {
                            moveTitleUp = false
                        } else {
                            moveTitleUp = true
                        }
                    })
                    .padding(.leading)
                    .font(.body.bold())
                    .frame(height: textFieldHeight)

                Spacer()
                rightBtnView
                    .padding(.trailing)
            }
            .background(
                TextfieldBackgroundBorderTitleView(title: title,
                                                   placeholder: placeholder,
                                                   textFieldHeight: textFieldHeight,
                                                   moveTitleUp: $moveTitleUp)
            )
        }
        .padding()
        .animation(.default, value: textFieldText)
    }
}


struct TextfieldBackgroundBorderTitleView: View {

    var title: String = ""
    var placeholder: String = ""
    var textFieldHeight: CGFloat = 60
    @Binding var moveTitleUp: Bool

    var body: some View {
        ZStack(alignment: .leading) {

            BorderedRoundRectangleView(cornerRadius: 5, borderColor: Color.gray)

            FloatingTitleView(title: title,
                              placeholder: placeholder,
                              textFieldHeight: textFieldHeight,
                              moveTitleUp: $moveTitleUp)
        }
    }
}

struct FloatingTitleView: View {

    var title: String = ""
    var placeholder: String = ""
    var textFieldHeight: CGFloat = 60
    @Binding var moveTitleUp: Bool

    var body: some View {

        Text(moveTitleUp ? title : placeholder)
            .foregroundColor(Color.secondary)
            .padding([.leading, .trailing], 5)
            .offset(x: 15, y: moveTitleUp ? -(textFieldHeight/2 + 5) : 0)
            .scaleEffect(moveTitleUp ? 0.9 : 1, anchor: .leading)
            .background(
                Color.white
                    .offset(x: 15, y: moveTitleUp ? -(textFieldHeight/2 + 5) : 0)
                    .scaleEffect(moveTitleUp ? 0.9 : 1, anchor: .leading)
            )
    }
}

struct BorderedRoundRectangleView: View {
    var cornerRadius: CGFloat = 5
    var borderColor: Color = .gray

    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius, style: .circular)
            .stroke(Color.gray, lineWidth: 1)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        AppThemeTextField(title: "Title",
                          placeholder: "Placeholder",
                          textFieldText: .constant(String()),
                          textFieldHeight: 60,
                          keyboardType: .default) {

        }
    }
}
