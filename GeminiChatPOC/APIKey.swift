//
//  APIKey.swift
//  GeminiChatPOC
//
//  Created by Piyush Rathi on 13/06/24.
//

import Foundation

enum APIKey {
    static var `default`: String {
        guard let filePath = Bundle.main.path(forResource: "GenerativeAI-Info", ofType: ".plist") else {
            fatalError("Could not file file 'GenerativeAI-Info'")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let apiKey = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Error in parsing file 'GenerativeAI-Info'")
        }
        if apiKey.starts(with: "_") {
            fatalError(
                "Follow the instruction to generate API_Key on https://ai.google.dev/tutorials/setup/ "
            )
        }
        return apiKey
    }
}
