//
//  ContentView.swift
//  checklist
//
//  Modified by Gabriel SAVINAUD on 9/29/25
//

import SwiftUI

struct ContentView: View {
    @State private var description: String = ""
    @State private var inProgress: [String] = []
    @State private var complete: [String] = []
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HeaderView(description: $description, inProgress: $inProgress)
                .padding(.horizontal, 20)
            ChecklistView(inProgress: $inProgress, complete: $complete)
        }
    }
}

struct HeaderView: View{
    @Binding var description: String
    @Binding var inProgress: [String]
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
                TextField("Enter description", text: $description)
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
                    if !description.isEmpty {
                        inProgress.append(description)
                        description = ""
                    }
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
    @Binding var inProgress: [String]
    @Binding var complete: [String]

    var body: some View {
        List {
            // In Progress
            Section(header: Text("TO DO").textCase(nil)) {
                ForEach(inProgress, id: \.self) { task in
                    HStack {
                        Text(task)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if let idx = inProgress.firstIndex(of: task) {
                            let moved = inProgress.remove(at: idx)
                            complete.append(moved)
                        }
                    }
                    .listRowBackground(Color.red)
                }
            }

            // Complete
            Section(header: Text("DONE").textCase(nil)) {
                ForEach(complete, id: \.self) { task in
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
                        if let idx = complete.firstIndex(of: task) {
                            let moved = complete.remove(at: idx)
                            inProgress.insert(moved, at: 0)
                        }
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
