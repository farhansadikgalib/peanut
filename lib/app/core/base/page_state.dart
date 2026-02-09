/// Enumeration of possible page states for UI state management.
/// 
/// Used throughout the app to consistently handle different UI states
/// and display appropriate feedback to users.
enum PageState {
  /// Initial/idle state of a page
  defaultState,
  
  /// Data is being loaded or processed
  loading,
  
  /// Operation completed successfully
  success,
  
  /// Operation failed with an error
  failed,
  
  /// Data was updated successfully
  updated,
  
  /// New data was created successfully
  created,
  
  /// No internet connection available
  noInternet,
  
  /// General message state for displaying info
  message,
  
  /// User is not authorized to access this resource
  unauthorized,
}
