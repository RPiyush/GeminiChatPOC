//
//  ContentView.swift
//  GeminiChatPOC
//
//  Created by Piyush Rathi on 13/06/24.
//

import SwiftUI
import GoogleGenerativeAI

struct ContentView: View {
    @State var textInput = ""
    @State var aiResponse = "Hello! How can I help you today?"
    let model = GenerativeModel(name: "gemini-pro", apiKey: APIKey.default)

    var body: some View {
        VStack {
            Image(.geminiLogo)
                .resizable()
                .scaledToFit()
                .frame(width: 200)
            ScrollView {
                Text(aiResponse)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
            }
            Text("Hello, world!")
            HStack {
                TextField("Enter a message", text: $textInput)
                    .textFieldStyle(.roundedBorder)
                    .foregroundStyle(.black)
                Button(action: sendMessage, label: {
                    Image(systemName: "paperplane.fill")
                })
            }
        }
            .foregroundColor(.white)
            .padding()
            .background {
            ZStack {
                Color(.black)
            }.ignoresSafeArea()
        }
    }

    func sendMessage() {
        aiResponse = ""
        Task {
            do {
                let response = try await model.generateContent(textInput)
                guard let text = response.text else {
                    textInput = "Sorry, I could not process that.\nPlease try again."
                    return
                }
                textInput = ""
                aiResponse = text
            } catch {
                aiResponse = "Something went wrong!\n\(error.localizedDescription)"
            }
        }
    }
}

#Preview {
    ContentView()
}
