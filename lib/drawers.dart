
  // ============================
  // DRAWER (STATIC FOR NOW)
  // ============================
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riderapp/features/auth/bloc/auth_bloc.dart';
import 'package:riderapp/features/auth/bloc/auth_event.dart';
import 'package:riderapp/features/auth/bloc/auth_state.dart';

Drawer buildAppDrawer(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;

    Widget tile({
      required String title,
      required IconData icon,
      required String route,
      VoidCallback? onTap,
    }) {
      final selected = currentRoute == route;

      return ListTile(
        leading: Icon(icon),
        title: Text(title),
        selected: selected,
        selectedTileColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        onTap: onTap ??
            () {
              if (!selected) {
                Navigator.pushNamed(context, route);
              } else {
                Navigator.pop(context);
              }
            },
      );
    }

    return Drawer(
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          // #usethis for testing login
          final isLoggedIn = state is AuthAuthenticated;

          return Column(
            children: [
              // ================= HEADER =================
              DrawerHeader(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'EverestMart',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              // ================= COMMON =================
              tile(
                title: 'Home',
                icon: Icons.home,
                route: '/',
              ),
              if(!isLoggedIn)
              tile(
                title: 'Products',
                icon: Icons.storefront,
                route: '/productsGuest',
              ),
              

              // ================= LOGGED IN =================
              if (isLoggedIn) ...[
                tile(
                  title: 'Products',
                  icon: Icons.storefront,
                  route: '/products',
                ),
                tile(
                  title: 'Cart',
                  icon: Icons.shopping_cart,
                  route: '/cart',
                ),
                tile(
                  title: 'Orders',
                  icon: Icons.receipt_long,
                  route: '/orders',
                ),
                tile(
                  title: 'Addresses',
                  icon: Icons.location_on,
                  route: '/addresses',
                ),
                tile(
                  title: 'Contact Us',
                  icon: Icons.support_agent,
                  route: '/contact',
                ),
                tile(
                  title: 'Settings',
                  icon: Icons.settings,
                  route: '/settings',
                ),
              ],

              const Spacer(),
              const Divider(),

              // ================= AUTH SECTION =================
              if (!isLoggedIn) ...[
                tile(
                  title: 'Login',
                  icon: Icons.login,
                  route: '/login',
                ),
                tile(
                  title: 'Register',
                  icon: Icons.app_registration,
                  route: '/register',
                ),
              ] else ...[
                ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  title: const Text('Profile'),
                  trailing: TextButton.icon(
                    icon: const Icon(Icons.logout),
                    label: const Text('Logout'),
                    onPressed: () {
                      context.read<AuthBloc>().add(LogoutRequested());
                      Navigator.pushReplacementNamed(context, '/');
                    },
                  ),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/profile');
                  },
                ),
              ],

              const SizedBox(height: 12),
            ],
          );
        },
      ),
    );
  }