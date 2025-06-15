import 'package:flutter/material.dart';
import 'package:movies_flutter/feat/profile/presentation/providers/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:movies_flutter/_core/constants/colors.dart';


class AvatarSelector extends StatelessWidget {
  const AvatarSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, provider, child) => Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: ColorsApp.gray,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            
            SizedBox(height: 24),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: provider.availableAvatars.length,
              itemBuilder: (context, index) {
                final avatar = provider.availableAvatars[index];
                final isSelected = avatar == provider.selectedAvatar;
                return GestureDetector(
                  onTap: () {
                    provider.updateProfile(avatar: avatar);
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? ColorsApp.yellow : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        avatar,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

