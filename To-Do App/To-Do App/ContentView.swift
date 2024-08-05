//
//  ContentView.swift
//  To-Do App
//
//  Created by siddhatech on 01/08/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = TaskViewModel()

    var body: some View {
      
            if viewModel.isAuthenticated {
                TaskListView(viewModel: viewModel)
            } else {
                AuthenticationView(viewModel: viewModel)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
