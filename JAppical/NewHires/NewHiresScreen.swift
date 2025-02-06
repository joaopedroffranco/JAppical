// Created in 2025

import SwiftUI
import JUI

struct NewHiresScreen: View {
	@State var showSortingOptions = false
	
	var body: some View {
		NewHiresView()
			.navigationBarTitleDisplayMode(.inline)
			.navigationTitle(Strings.newsHires)
			.navigationBarBackButtonHidden(false)
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					Button(action: {
						showSortingOptions = true
					}) {
						LocalImage(named: DesignSystem.Assets.sortIcon)
							.scaledToFit()
							.frame(width: 24, height: 24, alignment: .center)
					}
					.confirmationDialog("", isPresented: $showSortingOptions, titleVisibility: .hidden) {
						Button(Strings.NewHires.sortEarliest) {}
						Button(Strings.NewHires.sortLatest) {}
					}
				}
			}
	}
}
