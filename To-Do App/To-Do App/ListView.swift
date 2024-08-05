import SwiftUI

struct TaskListView: View {
    @ObservedObject var viewModel: TaskViewModel
    @State private var newTaskTitle: String = ""

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    viewModel.logout()
                }) {
                    Text("Logout")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                }
                .padding()
                
                Button(action: {
                    viewModel.deleteUserData()
                }) {
                    Text("Delete All Data")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                }
                .padding()
            }
            TextField("New Task", text: $newTaskTitle)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            Button(action: {
                viewModel.addTask(title: newTaskTitle)
                newTaskTitle = ""
            }) {
                Text("Add Task")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding()

            List {
                ForEach(viewModel.tasks) { task in
                    HStack {
                        Text(task.title)
                        Spacer()
                        if task.isCompleted {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                        } else {
                            Image(systemName: "circle")
                                .foregroundColor(.gray)
                        }
                    }
                    .onTapGesture {
                        viewModel.markTaskCompleted(task: task)
                    }
                }
                .onDelete(perform: viewModel.deleteTask)
            }
        }
        .padding()
    }
}
