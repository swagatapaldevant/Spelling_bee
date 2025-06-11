import 'package:flutter/material.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';

class LeaderboardSection extends StatelessWidget {
  final String firstRankName;
  final int firstRankCoin;
  final String secondRankName;
  final int secondRankCoin;
  final String thirdRankName;
  final int thirdRankCoin;
  const LeaderboardSection({super.key, required this.firstRankName, required this.firstRankCoin, required this.secondRankName, required this.secondRankCoin, required this.thirdRankName, required this.thirdRankCoin});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top 3 Users Section
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TopUserWidget(
                user: User(
                  name: secondRankName,
                  likes: secondRankCoin,
                  image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcStgaTAjf7ywAEf7IBOyVVwCuf6tR5tBJuteg&s', // Replace with actual image
                  rank: 2,
                ),
              ),
              TopUserWidget(
                user: User(
                  name: firstRankName,
                  likes: firstRankCoin,
                  image: 'https://img.freepik.com/free-vector/shiny-golden-number-one-star-label-design_1017-27875.jpg?semt=ais_hybrid&w=740',
                  rank: 1,
                ),
              ),
              TopUserWidget(
                user: User(
                  name: thirdRankName,
                  likes: thirdRankCoin,
                  image: 'https://cdn0.iconfinder.com/data/icons/social-media-gamification/1000/Third_Rank-512.png',
                  rank: 3,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TopUserWidget extends StatelessWidget {
  final User user;

  const TopUserWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    double avatarRadius;
    double verticalOffset;

    if (user.rank == 1) {
      avatarRadius = 45;
      verticalOffset = 0;
    } else {
      avatarRadius = 30;
      verticalOffset = 12;
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(height: verticalOffset),
          Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color:(user.rank == 1)?AppColors.alphabetSafeArea: (user.rank == 2)?AppColors.listenSpellBg: AppColors.welcomeButtonColor,
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: (user.rank == 1)?AppColors.alphabetSafeArea: (user.rank == 2)?AppColors.listenSpellBg: AppColors.welcomeButtonColor, width: 1)),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CircleAvatar(
                      radius: avatarRadius,
                      backgroundImage: NetworkImage(user.image),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: AppColors.alphabetSafeArea,
                  child: Text(
                    "${user.rank}",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 6),
          Text(user.name, style: TextStyle(
              fontFamily: "comic_neue",
            fontWeight: FontWeight.w700,
            color: AppColors.colorBlack,
            fontSize: 14
          )),
          Text(" ${user.likes}",
              style: TextStyle(  fontFamily: "comic_neue",
                  fontWeight: FontWeight.w600,
                  color: AppColors.colorBlack,
                  fontSize: 12)),
        ],
      ),
    );
  }
}

class User {
  final String name;
  final int likes;
  final String image;
  final int rank;

  User({
    required this.name,
    required this.likes,
    required this.image,
    required this.rank,
  });
}

