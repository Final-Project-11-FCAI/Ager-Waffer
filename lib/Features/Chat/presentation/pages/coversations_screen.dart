import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/Shimmer/loading_shimmer.dart';
import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Features/Chat/presentation/manager/all_chats_bloc.dart';
import 'package:ager_waffer/Features/Chat/presentation/manager/all_chats_state.dart';
import 'package:ager_waffer/Features/Chat/presentation/widgets/chat_card.dart';
import 'package:ager_waffer/Features/Chat/presentation/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart%20%20';

class ConversationsScreen extends StatefulWidget {
  const ConversationsScreen({super.key});

  @override
  State<ConversationsScreen> createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen> {
  TextEditingController emailCon = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AllChatsBloc>().add(GetAllChatsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chats"),
      ),
      body: BlocBuilder<AllChatsBloc,AllChatsState>(
        builder: (context, state) {
          if (state.status == allChatsStatus.loading) {
            return const LoadingPlaceHolder(
              shimmerType: ShimmerType.list,
              cellShimmerHeight: 50,
              shimmerCount: 10,
            );
          } else if (state.status == allChatsStatus.success){
            final chats = state.chats;
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: chats.length,
                        itemBuilder: (context, index) {
                          return ChatCard(chat: chats[index],);
                        }),
                  ),
                ],
              ),
            );
          } else if (state.status == allChatsStatus.failure) {
            return Center(child: Text(state.failureMessage));
          } else  {
            return Center(child: Text(kNoDataYet.tr()));
          }
        },
      ),
    );
  }
}