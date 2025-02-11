// Created in 2025
	
import SwiftUI

/// A custom list view that displays a collection of data items with customizable row views and spacing.
///
/// This view is designed to present a list of data elements with a custom row view for each item. The list allows for
/// flexible row customization, spacing between items, and easy integration with SwiftUI's view-building mechanism.
///
/// The `JList` component provides a way to create a list with:
/// - Custom row views, generated from a closure that takes an index and data element.
/// - Adjustable spacing between rows in the list.
///
/// ```
/// JList(data: ["Item 1", "Item 2", "Item 3"]) { _, element in
///     Text(element)
///         .frame(height: 50)
///         .background(Color.red)
/// }
/// ```
public struct JList<Data: Hashable, Row: View>: View {
	private var data: [Data]
	private var rowView: (Int, Data) -> Row
	private let spacing: CGFloat
	
	public init(
		data: [Data],
		spacing: CGFloat = .zero,
		@ViewBuilder row: @escaping (Int, Data) -> Row
	) {
		self.data = data
		self.rowView = row
		self.spacing = spacing
	}
	
	public var body: some View {
		List {
			ForEach(Array(data.enumerated()), id: \.offset) { offset, object in
				rowView(offset, object)
					.listRowInsets(
						.init(
							top: .zero,
							leading: .zero,
							bottom: spacing,
							trailing: .zero
						)
					)
					.listRowBackground(DesignSystem.Colors.background)
					.listRowSeparator(.hidden)
			}
		}
		.listStyle(.plain)
	}
}

struct JList_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			JList(data: ["a", "b", "c"]) { _, element in
				Text(element.description)
					.frame(height: 50)
					.frame(maxWidth: .infinity)
					.background(.red)
			}
			
			JList(data: [1, 2, 3, 4, 5], spacing: 10) { _, element in
				Text(element.description)
					.background(.red)
					.frame(height: 50)
					.frame(maxWidth: .infinity)
					.background(.red)
			}
		}
	}
}
