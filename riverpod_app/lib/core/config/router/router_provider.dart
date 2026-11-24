import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../features/auth/presentation/controllers/auth_controller.dart';
import '../../../features/auth/presentation/pages/login_page.dart';
import '../../../features/auth/presentation/pages/signup_page.dart';
import '../../../features/post/presentation/pages/post_detail_page.dart';
import '../../../features/post/presentation/pages/post_form_page.dart';
import '../../../features/post/presentation/pages/post_page.dart';
import '../../../features/profile/presentation/pages/edit_profile_page.dart';
import '../../../features/profile/presentation/pages/my_profile_page.dart';
import '../../../features/profile/presentation/pages/user_profile_page.dart';
import '../../../features/search/presentation/pages/search_page.dart';
import '../../../features/splash/presentation/pages/splash_page.dart';
import '../../widgets/error_page.dart';
import '../../widgets/scaffold_with_nav_bar.dart';
import 'route_constants.dart';

part 'router_provider.g.dart';

@riverpod
GoRouter router(Ref ref) {
  final authRefresh = ValueNotifier<int>(0);
  ref.onDispose(authRefresh.dispose);

  ref.listen<AuthState>(authControllerProvider, (prev, next) {
    authRefresh.value++;
  });

  return GoRouter(
    initialLocation: RoutePath.splash,
    refreshListenable: authRefresh,
    redirect: (BuildContext context, GoRouterState state) {
      final authStatus = ref.read(authControllerProvider).status;
      final location = state.matchedLocation;
      final isSplash = location == RoutePath.splash;
      final isAuthRoute =
          location == RoutePath.login || location == RoutePath.signup;
      if (authStatus == AuthStatus.unknown) {
        return isSplash ? null : RoutePath.splash;
      }
      if (authStatus == AuthStatus.authenticated) {
        if (isSplash || isAuthRoute) return RoutePath.post;
      } else {
        if (!isAuthRoute) return RoutePath.login;
      }
      return null;
    },
    routes: [
      // Splash
      GoRoute(
        path: RoutePath.splash,
        name: RouteNames.splash,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashPage();
        },
      ),
      // Login
      GoRoute(
        path: RoutePath.login,
        name: RouteNames.login,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
      ),
      // Signup
      GoRoute(
        path: RoutePath.signup,
        name: RouteNames.signup,
        builder: (BuildContext context, GoRouterState state) {
          return const SignupPage();
        },
      ),
      // Create Post
      GoRoute(
        path: RoutePath.postCreate,
        name: RouteNames.postCreate,
        builder: (BuildContext context, GoRouterState state) {
          return const PostFormPage();
        },
      ),
      // User profile
      GoRoute(
        path: RoutePath.userDetail,
        name: RouteNames.userDetail,
        builder: (BuildContext context, GoRouterState state) {
          final userId = state.pathParameters['userId']!;
          return UserProfilePage(userId: userId);
        },
      ),
      // Post detail
      GoRoute(
        path: RoutePath.postDetail,
        name: RouteNames.postDetail,
        builder: (BuildContext context, GoRouterState state) {
          final postId = state.pathParameters['postId']!;
          return PostDetailPage(postId: postId);
        },
        routes: [
          GoRoute(
            path: RoutePath.postEdit,
            name: RouteNames.postEdit,
            builder: (BuildContext context, GoRouterState state) {
              final postId = state.pathParameters['postId']!;
              return PostFormPage(postId: postId);
            },
          ),
        ],
      ),

      StatefulShellRoute.indexedStack(
        builder:
            (
              BuildContext context,
              GoRouterState state,
              StatefulNavigationShell navigationShell,
            ) {
              return ScaffoldWithNavBar(navigationShell: navigationShell);
            },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePath.post,
                name: RouteNames.post,
                builder: (BuildContext context, GoRouterState state) {
                  return const PostPage();
                },
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePath.search,
                name: RouteNames.search,
                builder: (BuildContext context, GoRouterState state) {
                  return const SearchPage();
                },
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePath.profile,
                name: RouteNames.profile,
                builder: (BuildContext context, GoRouterState state) {
                  return const MyProfilePage();
                },
                routes: [
                  GoRoute(
                    path: RoutePath.profileEdit,
                    name: RouteNames.profileEdit,
                    builder: (BuildContext context, GoRouterState state) {
                      return const EditProfilePage();
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) {
      return ErrorPage(error: state.error);
    },
  );
}
