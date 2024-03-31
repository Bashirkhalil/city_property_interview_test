import 'package:flutter/material.dart';

import '../../model/user_article.dart';

class UserRow extends StatefulWidget {

  User user;
  final Function(User user) onDelete;
  final Function(User user) onEdit;


  UserRow({
    required this.user ,
    required this.onEdit ,
    required this.onDelete , super.key});

  @override
  State<UserRow> createState() => _UserRowState();
}

class _UserRowState extends State<UserRow> {
  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0), // Set border radius here
        color: Colors.white, // Set container background color
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          imageHandler(widget.user.img_link),

          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const  SizedBox(height: 4),
                Text(
                  widget.user.description,
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
                const  SizedBox(height: 4),
                Text(
                  widget.user.email,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: Colors.green,
                ),
                onPressed: () {
                  widget.onEdit(widget.user);
                },
              ),
              IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    widget.onDelete(widget.user);
                  }),
            ],
          ),
        ],
      ),
    );
  }

  imageHandler(String img_link) {

   var mWidth = 80.0 ;
   var mHeight = 80.0 ;

   return Image.network(
     width: mWidth ,
     height: mHeight ,
     img_link,
      //'https://flutter.github.io/assets-for-api-docs/assets/widgets/falcon.jpg',

     frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
       if (wasSynchronouslyLoaded) {
         return child;
       }
       return AnimatedOpacity(
         opacity: frame == null ? 0 : 1,
         duration: const Duration(seconds: 1),
         curve: Curves.easeOut,
         child: child,
       );
     },

     loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return CircleAvatar(
            backgroundImage: NetworkImage(img_link),
          );
        }
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },

     errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
       return Image.asset(
         'images/default.png',
         width: mWidth,
         height: mHeight,
         fit: BoxFit.cover, // adjust the fit based on your needs
       );
     },


    );
  }


}
