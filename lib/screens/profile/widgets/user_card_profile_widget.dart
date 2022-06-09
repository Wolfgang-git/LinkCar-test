import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:linkcar/assets/colors.dart';
import 'package:linkcar/services/auth_service.dart';

class UserCardProfileWidget extends StatelessWidget {
  final String displayName;
  final bool isVerified;
  const UserCardProfileWidget({Key? key, required this.displayName, required this.isVerified}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.02),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.09,
                backgroundColor: const Color(LinkCarColors.blue),
                child: const FaIcon(
                  FontAwesomeIcons.camera,
                  color: Color(0xffffffff),
                  size: 28,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(displayName,
                        style: const TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.certificate,
                            color: Color(isVerified ? LinkCarColors.blue : LinkCarColors.red),
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            isVerified ? "Account verified" : "Account not verified",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(isVerified ? LinkCarColors.blue : LinkCarColors.red)),
                          ),
                          const SizedBox(width: 8.0),
                          Container(
                            child: !isVerified ? TextButton(
                              onPressed: () {
                                AuthenticationService().verifyEmail();
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
                                foregroundColor: MaterialStateProperty.all(const Color(LinkCarColors.blue)),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Verify",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(LinkCarColors.blue)),
                                )
                              )
                            ) : null,
                          )
                        ],
                      ),
                    ]
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
