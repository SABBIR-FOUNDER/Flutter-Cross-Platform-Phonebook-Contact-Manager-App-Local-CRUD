import 'package:flutter/material.dart';

import '../contact_model.dart';
import 'contact_avatar.dart';

class ContactTile extends StatelessWidget {
  final Contact contact;
  final VoidCallback? onTap;
  final VoidCallback? onFavouriteTap;

  const ContactTile({
    super.key,
    required this.contact,
    this.onTap,
    this.onFavouriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        child: Row(
          children: [
            ContactAvatar(
              contact: contact,
              radius: 24,
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 3),

                  if (contact.email.isNotEmpty)
                    Text(
                      contact.email,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),

                  const SizedBox(height: 2),

                  Text(
                    contact.phone,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            if (onFavouriteTap != null)
              IconButton(
                onPressed: onFavouriteTap,
                icon: Icon(
                  contact.isFavourite
                      ? Icons.star
                      : Icons.star_border,
                ),
                color: contact.isFavourite
                    ? Colors.amber
                    : Colors.grey.shade500,
                tooltip: contact.isFavourite
                    ? 'Remove from favourites'
                    : 'Add to favourites',
              ),

            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}