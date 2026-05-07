import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Animation preset types for quick configuration
enum SmartAnimatePreset {
  fadeIn,
  fadeSlideUp,
  fadeSlideDown,
  fadeSlideLeft,
  fadeSlideRight,
  scale,
  scaleUp,
  bounce,
  flip,
  blur,
  shimmer,
  shake,
}

/// Configuration for SmartAnimate effects
class SmartAnimateConfig {
  const SmartAnimateConfig({
    this.duration = const Duration(milliseconds: 400),
    this.delay = Duration.zero,
    this.curve = Curves.easeOutCubic,
    this.beginOffset = const Offset(0, 30),
    this.beginScale = 0.8,
    this.beginOpacity = 0.0,
  });

  final Duration duration;
  final Duration delay;
  final Curve curve;
  final Offset beginOffset;
  final double beginScale;
  final double beginOpacity;

  SmartAnimateConfig copyWith({
    Duration? duration,
    Duration? delay,
    Curve? curve,
    Offset? beginOffset,
    double? beginScale,
    double? beginOpacity,
  }) {
    return SmartAnimateConfig(
      duration: duration ?? this.duration,
      delay: delay ?? this.delay,
      curve: curve ?? this.curve,
      beginOffset: beginOffset ?? this.beginOffset,
      beginScale: beginScale ?? this.beginScale,
      beginOpacity: beginOpacity ?? this.beginOpacity,
    );
  }
}

/// A smart animation wrapper that animates its child using flutter_animate.
/// Supports visibility-based animations perfect for ListView items.
class SmartAnimate extends StatefulWidget {
  const SmartAnimate({
    required this.child,
    this.preset = SmartAnimatePreset.fadeSlideUp,
    this.config = const SmartAnimateConfig(),
    this.effects,
    this.autoPlay = true,
    this.animateOnVisibility = false,
    this.visibilityFraction = 0.1,
    this.onComplete,
    this.onInit,
    this.controller,
    this.enabled = true,
    super.key,
  });

  /// The child widget to animate
  final Widget child;

  /// Preset animation type for quick setup
  final SmartAnimatePreset preset;

  /// Animation configuration
  final SmartAnimateConfig config;

  /// Custom effects (overrides preset if provided)
  final List<Effect<dynamic>>? effects;

  /// Whether to auto play animation on build
  final bool autoPlay;

  /// Whether to trigger animation when widget becomes visible (for ListView)
  final bool animateOnVisibility;

  /// Fraction of widget that must be visible to trigger animation [0.0 - 1.0]
  final double visibilityFraction;

  /// Callback when animation completes
  final VoidCallback? onComplete;

  /// Callback when animation initializes
  final void Function(AnimationController)? onInit;

  /// External animation controller
  final AnimationController? controller;

  /// Whether animation is enabled
  final bool enabled;

  @override
  State<SmartAnimate> createState() => _SmartAnimateState();
}

class _SmartAnimateState extends State<SmartAnimate> {
  bool _hasAnimated = false;
  bool _isVisible = false;
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    if (!widget.animateOnVisibility) {
      _hasAnimated = true;
    }
  }

  List<Effect<dynamic>> _getEffectsForPreset() {
    final config = widget.config;

    switch (widget.preset) {
      case SmartAnimatePreset.fadeIn:
        return [
          FadeEffect(
            begin: config.beginOpacity,
            end: 1,
            duration: config.duration,
            curve: config.curve,
            delay: config.delay,
          ),
        ];

      case SmartAnimatePreset.fadeSlideUp:
        return [
          FadeEffect(
            begin: config.beginOpacity,
            end: 1,
            duration: config.duration,
            curve: config.curve,
            delay: config.delay,
          ),
          SlideEffect(
            begin: Offset(0, config.beginOffset.dy / 100),
            end: Offset.zero,
            duration: config.duration,
            curve: config.curve,
            delay: config.delay,
          ),
        ];

      case SmartAnimatePreset.fadeSlideDown:
        return [
          FadeEffect(
            begin: config.beginOpacity,
            end: 1,
            duration: config.duration,
            curve: config.curve,
            delay: config.delay,
          ),
          SlideEffect(
            begin: Offset(0, -config.beginOffset.dy / 100),
            end: Offset.zero,
            duration: config.duration,
            curve: config.curve,
            delay: config.delay,
          ),
        ];

      case SmartAnimatePreset.fadeSlideLeft:
        return [
          FadeEffect(
            begin: config.beginOpacity,
            end: 1,
            duration: config.duration,
            curve: config.curve,
            delay: config.delay,
          ),
          SlideEffect(
            begin: Offset(config.beginOffset.dx / 100, 0),
            end: Offset.zero,
            duration: config.duration,
            curve: config.curve,
            delay: config.delay,
          ),
        ];

      case SmartAnimatePreset.fadeSlideRight:
        return [
          FadeEffect(
            begin: config.beginOpacity,
            end: 1,
            duration: config.duration,
            curve: config.curve,
            delay: config.delay,
          ),
          SlideEffect(
            begin: Offset(-config.beginOffset.dx / 100, 0),
            end: Offset.zero,
            duration: config.duration,
            curve: config.curve,
            delay: config.delay,
          ),
        ];

      case SmartAnimatePreset.scale:
        return [
          FadeEffect(
            begin: config.beginOpacity,
            end: 1,
            duration: config.duration,
            curve: config.curve,
            delay: config.delay,
          ),
          ScaleEffect(
            begin: Offset(config.beginScale, config.beginScale),
            end: const Offset(1, 1),
            duration: config.duration,
            curve: config.curve,
            delay: config.delay,
          ),
        ];

      case SmartAnimatePreset.scaleUp:
        return [
          FadeEffect(
            begin: config.beginOpacity,
            end: 1,
            duration: config.duration,
            curve: config.curve,
            delay: config.delay,
          ),
          ScaleEffect(
            begin: const Offset(0.5, 0.5),
            end: const Offset(1, 1),
            duration: config.duration,
            curve: Curves.elasticOut,
            delay: config.delay,
          ),
        ];

      case SmartAnimatePreset.bounce:
        return [
          FadeEffect(
            begin: config.beginOpacity,
            end: 1,
            duration: config.duration,
            curve: config.curve,
            delay: config.delay,
          ),
          SlideEffect(
            begin: Offset(0, config.beginOffset.dy / 100),
            end: Offset.zero,
            duration: config.duration,
            curve: Curves.bounceOut,
            delay: config.delay,
          ),
        ];

      case SmartAnimatePreset.flip:
        return [
          FadeEffect(
            begin: config.beginOpacity,
            end: 1,
            duration: config.duration,
            curve: config.curve,
            delay: config.delay,
          ),
          FlipEffect(begin: 0.5, end: 0, duration: config.duration, curve: config.curve, delay: config.delay),
        ];

      case SmartAnimatePreset.blur:
        return [
          FadeEffect(
            begin: config.beginOpacity,
            end: 1,
            duration: config.duration,
            curve: config.curve,
            delay: config.delay,
          ),
          BlurEffect(
            begin: const Offset(10, 10),
            end: Offset.zero,
            duration: config.duration,
            curve: config.curve,
            delay: config.delay,
          ),
        ];

      case SmartAnimatePreset.shimmer:
        return [ShimmerEffect(duration: config.duration, delay: config.delay)];

      case SmartAnimatePreset.shake:
        return [
          FadeEffect(
            begin: config.beginOpacity,
            end: 1,
            duration: config.duration ~/ 2,
            curve: config.curve,
            delay: config.delay,
          ),
          ShakeEffect(hz: 4, duration: config.duration, delay: config.delay),
        ];
    }
  }

  void _checkVisibility() {
    if (_hasAnimated || !mounted) return;

    final renderBox = _key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) return;

    final size = renderBox.size;
    final position = renderBox.localToGlobal(Offset.zero);
    final screenSize = MediaQuery.of(context).size;

    // Calculate visible portion
    final visibleTop = position.dy.clamp(0.0, screenSize.height);
    final visibleBottom = (position.dy + size.height).clamp(0.0, screenSize.height);
    final visibleHeight = visibleBottom - visibleTop;
    final visibleFraction = size.height > 0 ? visibleHeight / size.height : 0.0;

    if (visibleFraction >= widget.visibilityFraction && !_isVisible) {
      setState(() {
        _isVisible = true;
        _hasAnimated = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return widget.child;
    }

    final effects = widget.effects ?? _getEffectsForPreset();

    if (widget.animateOnVisibility) {
      return NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          _checkVisibility();
          return false;
        },
        child: LayoutBuilder(
          key: _key,
          builder: (context, constraints) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _checkVisibility();
            });

            if (!_isVisible) {
              // Return invisible placeholder to maintain layout
              return Opacity(opacity: 0, child: widget.child);
            }

            return Animate(
              autoPlay: widget.autoPlay,
              controller: widget.controller,
              onComplete: widget.onComplete != null ? (_) => widget.onComplete!() : null,
              onInit: widget.onInit,
              effects: effects,
              child: widget.child,
            );
          },
        ),
      );
    }

    return Animate(
      autoPlay: widget.autoPlay,
      controller: widget.controller,
      onComplete: widget.onComplete != null ? (_) => widget.onComplete!() : null,
      onInit: widget.onInit,
      effects: effects,
      child: widget.child,
    );
  }
}

/// Extension for easy staggered animations in lists
extension SmartAnimateListExtension on List<Widget> {
  /// Wraps each widget with SmartAnimate for staggered list animations
  List<Widget> animateList({
    SmartAnimatePreset preset = SmartAnimatePreset.fadeSlideUp,
    SmartAnimateConfig config = const SmartAnimateConfig(),
    Duration staggerDelay = const Duration(milliseconds: 50),
    bool animateOnVisibility = false,
    double visibilityFraction = 0.1,
  }) {
    return asMap().entries.map((entry) {
      final index = entry.key;
      final widget = entry.value;
      return SmartAnimate(
        preset: preset,
        config: config.copyWith(delay: config.delay + (staggerDelay * index)),
        animateOnVisibility: animateOnVisibility,
        visibilityFraction: visibilityFraction,
        child: widget,
      );
    }).toList();
  }
}

/// A builder for creating animated ListView items with stagger effect
class SmartAnimateListBuilder extends StatelessWidget {
  /// Creates an animated ListView.builder
  const SmartAnimateListBuilder({
    required this.itemCount,
    required this.itemBuilder,
    this.preset = SmartAnimatePreset.fadeSlideUp,
    this.config = const SmartAnimateConfig(),
    this.staggerDelay = const Duration(milliseconds: 50),
    this.scrollController,
    this.scrollDirection = Axis.vertical,
    this.padding,
    this.physics,
    this.shrinkWrap = false,
    this.reverse = false,
    super.key,
  }) : separatorBuilder = null;

  /// Creates an animated ListView.separated
  const SmartAnimateListBuilder.separated({
    required this.itemCount,
    required this.itemBuilder,
    required Widget Function(BuildContext context, int index) this.separatorBuilder,
    this.preset = SmartAnimatePreset.fadeSlideUp,
    this.config = const SmartAnimateConfig(),
    this.staggerDelay = const Duration(milliseconds: 10),
    this.scrollController,
    this.scrollDirection = Axis.vertical,
    this.padding,
    this.physics,
    this.shrinkWrap = false,
    this.reverse = false,
    super.key,
  });

  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Widget Function(BuildContext context, int index)? separatorBuilder;
  final SmartAnimatePreset preset;
  final SmartAnimateConfig config;
  final Duration staggerDelay;
  final ScrollController? scrollController;
  final Axis scrollDirection;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    if (separatorBuilder != null) {
      return ListView.separated(
        controller: scrollController,
        scrollDirection: scrollDirection,
        padding: padding,
        physics: physics,
        shrinkWrap: shrinkWrap,
        reverse: reverse,
        itemCount: itemCount,
        separatorBuilder: separatorBuilder!,
        itemBuilder: (context, index) {
          return SmartAnimate(
            preset: preset,
            config: config.copyWith(delay: config.delay + (staggerDelay * index)),
            child: itemBuilder(context, index),
          );
        },
      );
    }

    return ListView.builder(
      controller: scrollController,
      scrollDirection: scrollDirection,
      padding: padding,
      physics: physics,
      shrinkWrap: shrinkWrap,
      reverse: reverse,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return SmartAnimate(
          preset: preset,
          config: config.copyWith(delay: config.delay + (staggerDelay * index)),
          child: itemBuilder(context, index),
        );
      },
    );
  }
}

/// A builder for creating animated GridView items with stagger effect
class SmartAnimateGridBuilder extends StatelessWidget {
  const SmartAnimateGridBuilder({
    required this.itemCount,
    required this.itemBuilder,
    required this.gridDelegate,
    this.preset = SmartAnimatePreset.scale,
    this.config = const SmartAnimateConfig(),
    this.staggerDelay = const Duration(milliseconds: 50),
    this.animateOnVisibility = false,
    this.visibilityFraction = 0.1,
    this.scrollController,
    this.scrollDirection = Axis.vertical,
    this.padding,
    this.physics,
    this.shrinkWrap = false,
    this.reverse = false,
    super.key,
  });

  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final SliverGridDelegate gridDelegate;
  final SmartAnimatePreset preset;
  final SmartAnimateConfig config;
  final Duration staggerDelay;
  final bool animateOnVisibility;
  final double visibilityFraction;
  final ScrollController? scrollController;
  final Axis scrollDirection;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      scrollDirection: scrollDirection,
      padding: padding,
      physics: physics,
      shrinkWrap: shrinkWrap,
      reverse: reverse,
      itemCount: itemCount,
      gridDelegate: gridDelegate,
      itemBuilder: (context, index) {
        return SmartAnimate(
          preset: preset,
          config: config.copyWith(delay: config.delay + (staggerDelay * index)),
          animateOnVisibility: animateOnVisibility,
          visibilityFraction: visibilityFraction,
          child: itemBuilder(context, index),
        );
      },
    );
  }
}

/// Sliver version for use with CustomScrollView
class SmartAnimateSliverList extends StatelessWidget {
  /// Creates an animated SliverList
  const SmartAnimateSliverList({
    required this.itemCount,
    required this.itemBuilder,
    this.preset = SmartAnimatePreset.fadeSlideUp,
    this.config = const SmartAnimateConfig(),
    this.staggerDelay = const Duration(milliseconds: 50),
    this.animateOnVisibility = true,
    this.visibilityFraction = 0.1,
    super.key,
  }) : separatorBuilder = null;

  /// Creates an animated SliverList with separators between items
  const SmartAnimateSliverList.separated({
    required this.itemCount,
    required this.itemBuilder,
    required Widget Function(BuildContext context, int index) this.separatorBuilder,
    this.preset = SmartAnimatePreset.fadeSlideUp,
    this.config = const SmartAnimateConfig(),
    this.staggerDelay = const Duration(milliseconds: 50),
    this.animateOnVisibility = true,
    this.visibilityFraction = 0.1,
    super.key,
  });

  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Widget Function(BuildContext context, int index)? separatorBuilder;
  final SmartAnimatePreset preset;
  final SmartAnimateConfig config;
  final Duration staggerDelay;
  final bool animateOnVisibility;
  final double visibilityFraction;

  @override
  Widget build(BuildContext context) {
    if (separatorBuilder != null) {
      // Calculate total count: items + separators (separators = itemCount - 1)
      final totalCount = itemCount > 0 ? (itemCount * 2) - 1 : 0;

      return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          // Even indices are items, odd indices are separators
          if (index.isEven) {
            final itemIndex = index ~/ 2;
            return SmartAnimate(
              preset: preset,
              config: config.copyWith(delay: config.delay + (staggerDelay * itemIndex)),
              animateOnVisibility: animateOnVisibility,
              visibilityFraction: visibilityFraction,
              child: itemBuilder(context, itemIndex),
            );
          } else {
            final separatorIndex = index ~/ 2;
            return separatorBuilder!(context, separatorIndex);
          }
        }, childCount: totalCount),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return SmartAnimate(
          preset: preset,
          config: config.copyWith(delay: config.delay + (staggerDelay * index)),
          animateOnVisibility: animateOnVisibility,
          visibilityFraction: visibilityFraction,
          child: itemBuilder(context, index),
        );
      }, childCount: itemCount),
    );
  }
}

/// Sliver version for GridView in CustomScrollView
class SmartAnimateSliverGrid extends StatelessWidget {
  const SmartAnimateSliverGrid({
    required this.itemCount,
    required this.itemBuilder,
    required this.gridDelegate,
    this.preset = SmartAnimatePreset.scale,
    this.config = const SmartAnimateConfig(),
    this.staggerDelay = const Duration(milliseconds: 50),
    this.animateOnVisibility = true,
    this.visibilityFraction = 0.1,
    super.key,
  });

  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final SliverGridDelegate gridDelegate;
  final SmartAnimatePreset preset;
  final SmartAnimateConfig config;
  final Duration staggerDelay;
  final bool animateOnVisibility;
  final double visibilityFraction;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate((context, index) {
        return SmartAnimate(
          preset: preset,
          config: config.copyWith(delay: config.delay + (staggerDelay * index)),
          animateOnVisibility: animateOnVisibility,
          visibilityFraction: visibilityFraction,
          child: itemBuilder(context, index),
        );
      }, childCount: itemCount),
      gridDelegate: gridDelegate,
    );
  }
}

//Examples and usages

/// ============================================================================
/// SMARTANIMATE EXAMPLES & USAGE GUIDE
/// ============================================================================
///
/// 1. BASIC USAGE - Single Widget Animation
/// ```dart
/// SmartAnimate(
///   preset: SmartAnimatePreset.fadeSlideUp,
///   child: Text('Hello World'),
/// )
/// ```
///
/// 2. WITH CUSTOM CONFIGURATION
/// ```dart
/// SmartAnimate(
///   preset: SmartAnimatePreset.scale,
///   config: const SmartAnimateConfig(
///     duration: Duration(milliseconds: 600),
///     delay: Duration(milliseconds: 200),
///     curve: Curves.easeOutBack,
///     beginScale: 0.5,
///   ),
///   child: MyCard(),
/// )
/// ```
///
/// 3. STAGGERED COLUMN ANIMATION
/// ```dart
/// Column(
///   children: [
///     Text('Title'),
///     Text('Subtitle'),
///     ElevatedButton(onPressed: () {}, child: Text('Button')),
///   ].animateList(
///     preset: SmartAnimatePreset.fadeSlideUp,
///     staggerDelay: Duration(milliseconds: 100),
///   ),
/// )
/// ```
///
/// 4. ANIMATED LISTVIEW
/// ```dart
/// SmartAnimateListBuilder(
///   itemCount: items.length,
///   itemBuilder: (context, index) => ListTile(title: Text(items[index])),
///   preset: SmartAnimatePreset.fadeSlideLeft,
///   staggerDelay: Duration(milliseconds: 50),
///   animateOnVisibility: true,
/// )
/// ```
///
/// 5. ANIMATED GRIDVIEW
/// ```dart
/// SmartAnimateGridBuilder(
///   itemCount: 20,
///   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
///   itemBuilder: (context, index) => ProductCard(index: index),
///   preset: SmartAnimatePreset.scale,
///   staggerDelay: Duration(milliseconds: 50),
/// )
/// ```
///
/// 6. IN CUSTOMSCROLLVIEW (SLIVERS)
/// ```dart
/// CustomScrollView(
///   slivers: [
///     SliverAppBar(title: Text('Products')),
///     SmartAnimateSliverGrid(
///       itemCount: products.length,
///       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
///       itemBuilder: (context, index) => ProductCard(products[index]),
///       preset: SmartAnimatePreset.scale,
///     ),
///   ],
/// )
/// ```
///
/// 7. AUTH FORM EXAMPLE (Staggered entrance)
/// ```dart
/// Column(
///   children: [
///     SmartAnimate(
///       preset: SmartAnimatePreset.fadeSlideDown,
///       config: SmartAnimateConfig(delay: Duration(milliseconds: 0)),
///       child: Logo(),
///     ),
///     SmartAnimate(
///       preset: SmartAnimatePreset.fadeSlideUp,
///       config: SmartAnimateConfig(delay: Duration(milliseconds: 100)),
///       child: EmailTextField(),
///     ),
///     SmartAnimate(
///       preset: SmartAnimatePreset.fadeSlideUp,
///       config: SmartAnimateConfig(delay: Duration(milliseconds: 200)),
///       child: PasswordTextField(),
///     ),
///     SmartAnimate(
///       preset: SmartAnimatePreset.scale,
///       config: SmartAnimateConfig(delay: Duration(milliseconds: 300)),
///       child: LoginButton(),
///     ),
///   ],
/// )
/// ```
///
/// 8. VISIBILITY-TRIGGERED ANIMATION (for lazy loading feel)
/// ```dart
/// SmartAnimate(
///   preset: SmartAnimatePreset.fadeSlideUp,
///   animateOnVisibility: true,
///   visibilityFraction: 0.2, // Triggers when 20% visible
///   child: ExpensiveWidget(),
/// )
/// ```
///
/// 9. WITH ANIMATION CALLBACKS
/// ```dart
/// SmartAnimate(
///   preset: SmartAnimatePreset.bounce,
///   onInit: (controller) {
///     // Store controller for manual control
///     _animController = controller;
///   },
///   onComplete: () {
///     print('Animation finished!');
///   },
///   child: MyWidget(),
/// )
/// ```
///
/// 10. CUSTOM EFFECTS (Advanced)
/// ```dart
/// SmartAnimate(
///   effects: [
///     FadeEffect(begin: 0, end: 1, duration: 400.ms),
///     ScaleEffect(begin: Offset(0.8, 0.8), end: Offset(1, 1), duration: 400.ms),
///     BlurEffect(begin: Offset(10, 10), end: Offset.zero, duration: 400.ms),
///   ],
///   child: ProfileCard(),
/// )
/// ```
///
/// 11. DISABLED ANIMATION (useful for testing/accessibility)
/// ```dart
/// SmartAnimate(
///   preset: SmartAnimatePreset.fadeSlideUp,
///   enabled: false, // Widget renders immediately without animation
///   child: MyWidget(),
/// )
/// ```
///
/// 12. LISTVIEW WITH SEPARATOR
/// ```dart
/// SmartAnimateListBuilder(
///   itemCount: messages.length,
///   itemBuilder: (context, index) => MessageTile(messages[index]),
///   separatorBuilder: (context, index) => Divider(),
///   preset: SmartAnimatePreset.fadeSlideRight,
///   staggerDelay: Duration(milliseconds: 30),
/// )
/// ```
///
/// ============================================================================
/// AVAILABLE PRESETS
/// ============================================================================
/// - fadeIn          : Simple opacity fade
/// - fadeSlideUp     : Fade + slide from bottom (great for lists)
/// - fadeSlideDown   : Fade + slide from top (great for headers)
/// - fadeSlideLeft   : Fade + slide from right
/// - fadeSlideRight  : Fade + slide from left
/// - scale           : Fade + scale up (great for cards/grids)
/// - scaleUp         : Elastic scale effect (playful)
/// - bounce          : Bouncy entrance from bottom
/// - flip            : 3D flip effect
/// - blur            : Blur to focus transition
/// - shimmer         : Shimmer/shine effect
/// - shake           : Attention-grabbing shake
///
/// ============================================================================
/// TIPS
/// ============================================================================
/// - Use `fadeSlideUp` for vertical lists
/// - Use `scale` for grid items
/// - Use `bounce` for buttons and interactive elements
/// - Use `blur` for hero/featured content
/// - Keep `staggerDelay` between 30-100ms for smooth staggered effects
/// - Set `animateOnVisibility: true` for long lists to improve performance
/// ============================================================================
