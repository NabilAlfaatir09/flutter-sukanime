import 'package:flutter/material.dart';
import 'package:flutter_list_anime/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter_list_anime/app/modules/widgets/loading_widget.dart';
import 'package:flutter_list_anime/app/modules/widgets/nointernet_widget.dart';
import 'package:flutter_list_anime/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/all_top_anime_controller.dart';

class AllTopAnimeView extends GetView<AllTopAnimeController> {
  const AllTopAnimeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final darkMode = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Top Anime',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        shadowColor: Colors.black,
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Obx(
          () => (controller.connectionType.value == 0)
              ? const NoInternet()
              : (controller.isLoading.value)
                  ? LoadingWidget(
                      color:
                          (darkMode.isDark.value) ? Colors.white : Colors.black,
                      text: "Memuat list Anime....",
                      mediaQuery: MediaQuery.of(context).size.height * 0.9,
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              (controller.isFirstPage.value)
                                  ? const Text("")
                                  : InkWell(
                                      highlightColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      onTap: () =>
                                          controller.fetchPreviousPage(),
                                      child: Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: (darkMode.isDark.value)
                                              ? Colors.grey[800]
                                              : Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: const Icon(
                                          Icons.arrow_back_ios_new,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${controller.currentPage}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                "Of",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                "1007",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () => controller.fetchNextPage(),
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: (darkMode.isDark.value)
                                        ? Colors.grey[800]
                                        : Colors.black,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15,
                            childAspectRatio: 1.5 / 2.3,
                          ),
                          padding: const EdgeInsets.all(8.0),
                          itemBuilder: (context, index) {
                            var animeTopCard = controller.allTopAnime[index];
                            return InkWell(
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () => Navigator.pushNamed(
                                context,
                                Routes.DETAIL,
                                arguments: {
                                  "id": animeTopCard.malId,
                                  "image": animeTopCard.imageUrl,
                                  "title": animeTopCard.title,
                                  "aired": animeTopCard.airedFrom,
                                  "type": animeTopCard.type,
                                  "rating": animeTopCard.rating,
                                  "score": animeTopCard.score,
                                  "member": animeTopCard.members,
                                  "youtube": animeTopCard.youtubeUrl,
                                },
                              ),
                              child: Card(
                                elevation: 5,
                                shadowColor: Colors.black,
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          animeTopCard.imageUrl,
                                          fit: BoxFit.cover,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          width:
                                              MediaQuery.of(context).size.width,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              flex: 1,
                                              child: Text(
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                animeTopCard.title,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                            const Flexible(
                                              flex: 1,
                                              child: Icon(
                                                Icons.bookmark_border_outlined,
                                                color: Colors.blue,
                                                size: 30,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: controller.allTopAnime.length,
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
