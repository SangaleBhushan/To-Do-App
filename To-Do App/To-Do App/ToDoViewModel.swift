import Combine
import SwiftUI

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var isAuthenticated: Bool = false
    
    private let userDefaults = UserDefaults.standard
    private let tasksKey = "tasksKey"
    private let userKey = "userKey"

    init() {
        loadTasks()
        checkAuthentication()
    }
    
    func loadTasks() {
        if let data = userDefaults.data(forKey: tasksKey),
           let savedTasks = try? JSONDecoder().decode([Task].self, from: data) {
            tasks = savedTasks
        }
    }

    func saveTasks() {
        if let data = try? JSONEncoder().encode(tasks) {
            userDefaults.set(data, forKey: tasksKey)
        }
    }
    
    func addTask(title: String) {
        let task = Task(title: title)
        tasks.append(task)
        saveTasks()
    }
    
    func markTaskCompleted(task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
            saveTasks()
        }
    }
    
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
        saveTasks()
    }
    
    func register(username: String, password: String) {
        let user = User(username: username, password: password)
        if let data = try? JSONEncoder().encode(user) {
            userDefaults.set(data, forKey: userKey)
            isAuthenticated = true
        }
    }
    
    func login(username: String, password: String) -> Bool {
        if let data = userDefaults.data(forKey: userKey),
           let savedUser = try? JSONDecoder().decode(User.self, from: data) {
            if savedUser.username == username && savedUser.password == password {
                isAuthenticated = true
                return true
            }
        }
        return false
    }
    
    func logout() {
        isAuthenticated = false
    }
    
    func deleteUserData() {
        userDefaults.removeObject(forKey: tasksKey)
        userDefaults.removeObject(forKey: userKey)
        tasks.removeAll()
        isAuthenticated = false
    }
    
    private func checkAuthentication() {
        if userDefaults.data(forKey: userKey) != nil {
            isAuthenticated = true
        }
    }
}
