import 'package:flutter/material.dart';
import 'package:mintyn/core/constants/app_color.dart';
import 'package:mintyn/core/constants/app_size.dart';

/// Small reusable loading indicator used across the app.
class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key, this.size = 20, this.color = AppColor.white});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator.adaptive(strokeWidth: 2));
  }
}

/// A polished, reusable error state widget.
///
/// Usage:
/// ```dart
/// AppErrorState(
///   message: error,
///   onRetry: () => cubit.fetchData(),
/// )
/// ```
class AppErrorState extends StatelessWidget {
  const AppErrorState({
    super.key,
    this.title = 'Oops something went wrong',
    this.message = 'An unexpected error occurred.\nPlease try again.',
    this.icon = Icons.wifi_tethering_error_rounded_outlined,
    this.onRetry,
    this.retryLabel = 'Try again',
    this.iconColor = AppColor.red50,
  });

  final String title;
  final String message;
  final IconData icon;
  final VoidCallback? onRetry;
  final String retryLabel;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(color: iconColor.withValues(alpha: 0.12), shape: BoxShape.circle),
              child: Icon(icon, size: 36, color: iconColor),
            ),
            AppSizes.h(16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            AppSizes.h(8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: isDark ? AppColor.grey700 : AppColor.grey500, height: 1.5),
            ),
            if (onRetry != null) ...[
              AppSizes.h(24),
              OutlinedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded, size: 16),
                label: Text(retryLabel),
                style: OutlinedButton.styleFrom(
                  foregroundColor: isDark ? AppColor.white : AppColor.primary,
                  side: BorderSide(color: isDark ? AppColor.grey600 : AppColor.grey300),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// A polished, reusable empty state widget.
///
/// Usage:
/// ```dart
/// AppEmptyState(
///   title: 'No products found',
///   subtitle: 'Try adjusting your filters.',
///   onAction: () => cubit.refresh(),
///   actionLabel: 'Refresh',
/// )
/// ```
class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    super.key,
    this.title = 'Nothing here yet',
    this.subtitle = "Looks like there's nothing to show right now.",
    this.icon = Icons.inbox_outlined,
    this.onAction,
    this.actionLabel = 'Refresh',
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onAction;
  final String actionLabel;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: isDark ? AppColor.grey600.withValues(alpha: 0.4) : AppColor.grey100,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 36, color: isDark ? AppColor.grey700 : AppColor.grey500),
            ),
            AppSizes.h(16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            AppSizes.h(8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: isDark ? AppColor.grey700 : AppColor.grey500, height: 1.5),
            ),
            if (onAction != null) ...[
              AppSizes.h(24),
              OutlinedButton.icon(
                onPressed: onAction,
                icon: const Icon(Icons.refresh_rounded, size: 16),
                label: Text(actionLabel),
                style: OutlinedButton.styleFrom(
                  foregroundColor: isDark ? AppColor.white : AppColor.primary,
                  side: BorderSide(color: isDark ? AppColor.grey600 : AppColor.grey300),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
