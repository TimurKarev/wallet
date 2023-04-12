import 'package:go_router/go_router.dart';
import 'package:wallet/presentation/blocs/auth/auth_bloc.dart';
import 'package:wallet/presentation/pages/auth/loading_page.dart';
import 'package:wallet/presentation/pages/auth/loging_page.dart';
import 'package:wallet/presentation/pages/home/home_page.dart';
import 'package:wallet/router/paths.dart' as paths;

GoRouter routerConfig(AuthBloc bloc) => GoRouter(
      refreshListenable: bloc,
      routes: [
        GoRoute(
          path: paths.start,
          builder: (context, state) => const LoadingPage(),
        ),
        GoRoute(
          path: paths.home,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: paths.login,
          builder: (context, state) => const LoginPage(),
        ),
      ],
      redirect: (_, state) {
        if (state.location == paths.start) {
          return bloc.state.mapOrNull(
            unknown: (_) => paths.login,
            success: (_) => paths.home,
          );
        }

        if (state.location != paths.login) {
          return bloc.state.mapOrNull(
            unknown: (_) => paths.login,
          );
        }
        return null;
      },
    );
