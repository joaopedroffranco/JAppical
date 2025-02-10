//
//  Created by Joao Pedro Franco on 16/07/24.
//

import Foundation

public protocol JSONFileProtocol {
	var name: String { get }
}

/// This enum provides a clear and organized way to reference JSON file names in the application.
public enum JSONFile: JSONFileProtocol {
	case regularNewHires
	case irregularNewHires
	case emptyNewHires
	case regularTasks
	case regularTask
	case irregularTasks
	case emptyTasks

	public var name: String {
		switch self {
		case .regularNewHires: return "regular_hires"
		case .irregularNewHires: return "irregular_hires"
		case .emptyNewHires: return "empty_hires"
		case .regularTasks: return "regular_tasks"
		case .regularTask: return "regular_task"
		case .irregularTasks: return "irregular_tasks"
		case .emptyTasks: return "empty_tasks"
		}
	}
}
