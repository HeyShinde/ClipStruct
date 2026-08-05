# Changelog

All notable changes to this project will be documented in this file.

## [2.0.2] - 2026-08-05

### Fixed
- Fixed a macOS AppKit bug where copying an item via the popover caused the entire ClipStruct window to jump to the left edge of the screen. This was due to the menubar icon swapping sizes while the popover anchor was active.
- Fixed hit-testing for nested buttons inside item cards. Clicking the "Delete" or "Pin" buttons on an image item now correctly performs the action instead of accidentally copying the item.
- Ensured the green "Copied" checkmark overlay is always perfectly centered across the entire grid cell width, instead of shrinking around smaller items like color previews.
