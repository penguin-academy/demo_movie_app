import 'package:demo_app/presentation/movies/controllers/home_view_controller.dart';
import 'package:demo_app/presentation/movies/views/movie_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeView extends StatefulHookConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    final homeViewController = ref.read(homeViewProvider);

    homeViewController.fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    final homeViewController = ref.watch(homeViewProvider);

    return Scaffold(
      drawer: const Drawer(),
      backgroundColor: Colors.black,
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HomeHeader(),
            const SizedBox(height: 40),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 18.0),
                  child: Text(
                    "Popular",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("SEE ALL")),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 300,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: homeViewController.movies.length,
                itemBuilder: (context, index) {
                  return MovieCard(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return MovieDetailView(
                            movie: homeViewController.movies[index]);
                      }));
                    },
                    imageUrl:
                        "https://image.tmdb.org/t/p/w200/${homeViewController.movies[index].posterPath}",
                    title: homeViewController.movies[index].title,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final void Function() onPressed;
  const MovieCard(
      {required this.imageUrl,
      required this.title,
      required this.onPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 150,
        padding: const EdgeInsets.only(right: 12.0),
        child: Column(
          children: [
            Image.network(
              imageUrl,
              height: 200,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          color: Colors.grey,
          thickness: 2,
          height: 0.8,
        ),
        Image.asset(
          'assets/images/dr_strange_culo.png',
          height: 320,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 48.0, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(children: const [
                Icon(
                  Icons.star,
                  color: Colors.red,
                  size: 30,
                ),
                SizedBox(width: 5),
                Text("8.5",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ]),
              const Text("1h 55m",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text("TRENDING")),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: Text(
            "Doctor Strange in the Multiverse of Madness",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              icon: const Icon(Icons.play_arrow, color: Colors.white),
              label: const Text("PLAY TRAILER",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 30),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[900],
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Icon(Icons.info, size: 36),
            ),
          ],
        ),
      ],
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Builder(builder: (context) {
        return IconButton(
          padding: const EdgeInsets.only(left: 20),
          icon: const Icon(Icons.menu, size: 35),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        );
      }),
      backgroundColor: Colors.black,
      title: const Text(
        'MY MOVIES DB',
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.bold, fontSize: 25),
      ),
      actions: [
        IconButton(
          padding: const EdgeInsets.only(right: 20),
          icon: const Icon(Icons.search, size: 35),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
