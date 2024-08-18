//
//  SearchView.swift
//  swiftui_architechture
//
//  Created by michael on 2024/8/18.
//

import SwiftUI
import Combine

struct SearchView: View {
    @StateObject private var userSettings = UserSettings.shared
    @ObservedObject  var viewModel: SearchViewModel = SearchViewModel()

    
    var body: some View {
            NavigationView{
                VStack {
                    if userSettings.userToken.isEmpty{
                        // Login Button
                        Button(action: {
                            userSettings.showLogin.toggle()
                        }) {
                            Text("Login")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(UIColor.systemBlue))
                                .foregroundColor(Color(UIColor.systemBackground))
                                .cornerRadius(8)
                        }
                        .padding()
                    } else {
                        // Search Bar
                        TextField("Search", text: $viewModel.searchText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        List(viewModel.mostStarRepositories) {repository in
                            RepositoryRow(repository: repository)
                        }
                    }
                }
                .navigationTitle("Search")
                
            }
    }
}

struct RepositoryRow: View {
    
    @State var repository: RepositoryResponse
    
    var circleSize: CGFloat = 12.0
    
    var body: some View {
        HStack {
            CircleImageView(imgUrl: repository.owner?.avatar_url)
            VStack(alignment: .leading) {
                Text(repository.full_name ?? "")
                    .font(Font.callout).bold()
                    .lineLimit(1)
                Text(repository.description ?? "")
                    .font(.caption2)
                    .lineLimit(2)
                Spacer()
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 5, content: {
                    starsView
                    forksView
                    watchersView
                    languageView
                })
            }
        }
        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    }
    
    var starsView: some View {
        HStack(spacing: 5) {
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
                .font(.caption)
            Text(String(describing: repository.stargazers_count))
                .font(.system(size: 10.0))
                .opacity(0.5)
                .lineLimit(1)
        }
    }
    
    var forksView: some View {
        HStack(spacing: 0) {
            Image(systemName: "tuningfork")
                //.resizable()
                .rotationEffect(Angle(degrees: -45.0))
                .foregroundColor(.gray)
                //.scaledToFill()
                //.frame(width: 10.0, height:5)
                .scaleEffect(CGSize(width: 0.75, height: 0.5))
            Text(String(describing:repository.forks))
                .font(.system(size: 10.0))
                .opacity(0.5)
                .lineLimit(1)
        }
    }
    
    var watchersView: some View {
        HStack(spacing: 0) {
            Image(systemName: "eye.fill")
                .foregroundColor(.gray)
                .scaleEffect(0.6)
            Text(String(describing:repository.watchers))
                .font(.system(size: 10.0))
                .opacity(0.5)
                .lineLimit(1)
        }
    }
    
    var languageView: some View {
        Group {
            Spacer()
            Text("Swift")
                .font(.caption2)
                .lineLimit(1)
            Circle()
                .foregroundColor(Color(hex: "#ffac45"))
                .frame(width: circleSize, height: circleSize)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}


extension SearchView {
    class SearchViewModel: ObservableObject {
        @Published var searchText: String = ""
        @Published private(set) var mostStarRepositories: [RepositoryResponse] = []
        private var cancellables: Set<AnyCancellable> = []

        init() {
            setupBindings()
        }
        
        private func setupBindings() {
               $searchText
                   .debounce(for: .seconds(0.4), scheduler: RunLoop.main)
                   .removeDuplicates()
                   .sink { [weak self] text in
                       print(text)
                       self?.getMostStarRepositories(keyword: text)
                   }
                   .store(in: &cancellables)
           }
        
        private func getMostStarRepositories(language: String = "Swift", keyword: String) -> Void {
            
            var components = URLComponents(string: Constants.mostStarUrl)!
            components.queryItems = [
                URLQueryItem(name: "q", value: "\(keyword)+stars:>=1+language:\(language)"),
//                URLQueryItem(name: "sort", value: "stars"),
//                URLQueryItem(name: "order", value: "desc"),
//                URLQueryItem(name: "per_page", value: 10.description),
//                URLQueryItem(name: "name", value: keyword)
            ]
            let url = URLRequest(url: components.url!)
            print(url)
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                 
                if error == nil {
                    guard let data = data else { return }
                    do {
                        let response = try JSONDecoder().decode(SearchRepositoryResponse.self, from: data)
                        DispatchQueue.main.async {
                            self.mostStarRepositories = response.items ?? []
                        }
                        //print("Response................. \(response)")
                    } catch let error {
                        print("ERROR..................\n \(error)")
                    }
                }
            }.resume()
            
        }
    }

}
