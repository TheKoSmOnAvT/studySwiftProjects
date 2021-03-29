//
//  NotecreationView.swift
//  FireBaseNotes
//
//  Created by Никита Попов on 09.02.2021.
//

import SwiftUI

struct NotecreationView: View {
    var fb : FireBase
    @State private var title : String = ""
    @State private var text : String = ""
    public var actionName : String = "Add note"
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            Spacer()
            
            TextField("Title", text: $title)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .padding()
            
            TextEditor(text: $text)
                .frame(
                       height: UIScreen.main.bounds.size.height * 0.6,
                       alignment: .center)
                .cornerRadius(12)
                .padding()

            Button(action: {
                fb.appendNote(NoteFileModel(title: self.title, text: self.text) )
            }, label: {
                    Text(actionName)
                        .font(.custom( "Helvetica Neue",fixedSize: 20))
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
            })
            Spacer()
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing)
        ).ignoresSafeArea()
    }
}

//struct NotecreationView_Previews: PreviewProvider {
//    static var previews: some View {
//        NotecreationView()
//    }
//}
