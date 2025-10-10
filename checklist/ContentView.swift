//
//  ContentView.swift
//  checklist
//
//  Modified by Gabriel SAVINAUD on 9/29/25
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HeaderView(viewModel: viewModel)
                .padding(.horizontal, 20)
            ChecklistView(viewModel: viewModel)
        }
    }
}

struct HeaderView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 16) {
                Image("techatace")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 72, height: 72)
                    .offset(x: 0, y: 0)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.gray.opacity(0.35), lineWidth: 1)
                    )
                
                Text("Tech at ACE")
                    .font(.system(size: 28, weight: .bold))
            }
            HStack(spacing: 12) {
                TextField("Enter description", text: $viewModel.description)
                    .textFieldStyle(.plain)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(.systemBackground))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                    .frame(maxWidth: .infinity)
                
                Button {
                    viewModel.addTask()
                } label: {
                    Text("Add")
                        .padding(.horizontal, 15)
                        .padding(.vertical, 5)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
            }
        }
    }
}

struct ChecklistView: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        List {
            // In Progress
            Section(header: Text("TO DO").textCase(nil)) {
                ForEach(viewModel.inProgressTasks, id: \.self) { task in
                    HStack {
                        Text(task)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.completeTask(task)
                    }
                    .listRowBackground(Color.red)
                }
            }

            // Complete
            Section(header: Text("DONE").textCase(nil)) {
                ForEach(viewModel.completedTasks, id: \.self) { task in
                    HStack {
                        Image(systemName: "checkmark")
                            .foregroundColor(.white)
                        Text(task)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.uncompleteTask(task)
                    }
                    .listRowBackground(Color.green)
                }
            }
        }
        .foregroundColor(.black)
        .fontWeight(.bold)
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .background(Color.white)
    }
}

#Preview {
     ContentView()
}
