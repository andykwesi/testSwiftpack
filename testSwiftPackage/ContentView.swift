import SwiftUI

struct ContentView: View {
    @State private var responseText = ""

    var body: some View {
        VStack {
            Text("API Response:")
            Text(responseText)
                .padding()
            
            Button(action: {
                testAPI()
            }) {
                Text("Test API")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .onAppear {
            // You can perform any initial setup here
        }
    }
    
    func testAPI() {
        guard let url = URL(string: "endpoint url") else {
            return
        }
        
        let accessToken = ""

        let payload: [String: Any] = [
            "source_wallet": "9d0237a0-8362-4cb0-8595-a006e3b0bb1c",
            "external_account_id": "",
            "amount": 0.50,
            "service": 14,
            "note": "airtime",
            "destination_phone": ""
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: payload)
        } catch {
            print("Error encoding payload: \(error)")
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let data = data {
                if let responseString = String(data: data, encoding: .utf8) {
                    DispatchQueue.main.async {
                        self.responseText = responseString
                    }
                }
            }
        }

        task.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
