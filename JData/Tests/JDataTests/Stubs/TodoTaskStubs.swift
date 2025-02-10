// Created in 2025

import Foundation
import JData

enum TodoTaskStubs {
	static let instance = TodoTask(id: "1", text: "task 1", dueDate: 12345678, isDone: false, isRemoteUpdated: true)
	
	static let manyNotDone = [
		TodoTask(id: "1", text: "task 1", dueDate: 12345678, isDone: false, isRemoteUpdated: true),
		TodoTask(id: "2", text: "task 1", dueDate: 12345678, isDone: false, isRemoteUpdated: true)
	]
	
	static let manyNotRemoteUpdated = [
		TodoTask(id: "1", text: "task 1", dueDate: 12345678, isDone: false, isRemoteUpdated: true),
		TodoTask(id: "2", text: "task 2", dueDate: 12345678, isDone: false, isRemoteUpdated: false),
		TodoTask(id: "3", text: "task 3", dueDate: 12345678, isDone: false, isRemoteUpdated: true)
	]
}
