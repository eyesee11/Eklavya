import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

/// Global error widget for handling application errors
class AppErrorWidget extends StatelessWidget {
  final String error;
  final VoidCallback? onRetry;
  final String? title;
  final IconData? icon;
  final bool showStackTrace;

  const AppErrorWidget({
    super.key,
    required this.error,
    this.onRetry,
    this.title,
    this.icon,
    this.showStackTrace = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(UIConstants.spacingLarge),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Error Icon
                Icon(
                  icon ?? Icons.error_outline,
                  size: 80,
                  color: Theme.of(context).colorScheme.error,
                ),
                
                const SizedBox(height: UIConstants.spacingLarge),
                
                // Error Title
                Text(
                  title ?? 'Oops! Something went wrong',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: UIConstants.spacingMedium),
                
                // Error Message
                Container(
                  padding: const EdgeInsets.all(UIConstants.spacingMedium),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(UIConstants.borderRadiusMedium),
                  ),
                  child: Text(
                    _getDisplayError(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onErrorContainer,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                
                const SizedBox(height: UIConstants.spacingLarge),
                
                // Action Buttons
                Column(
                  children: [
                    if (onRetry != null) ...[
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: onRetry,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Try Again'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            foregroundColor: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(height: UIConstants.spacingMedium),
                    ],
                    
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Go Back'),
                      ),
                    ),
                  ],
                ),
                
                // Developer Information (Debug mode only)
                if (showStackTrace) ...[
                  const SizedBox(height: UIConstants.spacingLarge),
                  ExpansionTile(
                    title: const Text('Technical Details'),
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(UIConstants.spacingMedium),
                        margin: const EdgeInsets.all(UIConstants.spacingSmall),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(UIConstants.borderRadiusSmall),
                        ),
                        child: SelectableText(
                          error,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Get user-friendly error message
  String _getDisplayError() {
    // Map technical errors to user-friendly messages
    if (error.contains('SocketException') || error.contains('NetworkException')) {
      return AppConstants.networkErrorMessage;
    } else if (error.contains('TimeoutException')) {
      return 'The request timed out. Please check your connection and try again.';
    } else if (error.contains('FormatException')) {
      return 'Invalid data format received. Please try again.';
    } else if (error.contains('PermissionException')) {
      return 'Required permissions are not granted. Please check app permissions.';
    } else if (error.contains('AuthException')) {
      return 'Authentication failed. Please log in again.';
    } else if (error.contains('ValidationException')) {
      return 'Invalid input provided. Please check your data and try again.';
    } else if (error.length > 200) {
      // Truncate very long error messages
      return '${error.substring(0, 200)}...';
    }
    
    return error.isEmpty ? AppConstants.genericErrorMessage : error;
  }
}

/// Compact error widget for inline errors
class CompactErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final double? height;

  const CompactErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 120,
      width: double.infinity,
      padding: const EdgeInsets.all(UIConstants.spacingMedium),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: Theme.of(context).colorScheme.error,
            size: 32,
          ),
          const SizedBox(height: UIConstants.spacingSmall),
          Text(
            message,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: UIConstants.spacingSmall),
            TextButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ],
      ),
    );
  }
}

/// Error widget for list items
class ListErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ListErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(UIConstants.spacingMedium),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: Theme.of(context).colorScheme.error,
            size: 24,
          ),
          const SizedBox(width: UIConstants.spacingMedium),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          if (onRetry != null) ...[
            const SizedBox(width: UIConstants.spacingMedium),
            IconButton(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              tooltip: 'Retry',
            ),
          ],
        ],
      ),
    );
  }
}
