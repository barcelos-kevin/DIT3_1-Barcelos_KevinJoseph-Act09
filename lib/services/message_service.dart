import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Message {
  final String id;
  final String text;
  final String senderEmail;
  final String senderName;
  final DateTime timestamp;

  Message({
    required this.id,
    required this.text,
    required this.senderEmail,
    required this.senderName,
    required this.timestamp,
  });

  factory Message.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Message(
      id: doc.id,
      text: data['text'] ?? '',
      senderEmail: data['senderEmail'] ?? 'Unknown',
      senderName: data['senderName'] ?? 'Anonymous',
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'senderEmail': senderEmail,
      'senderName': senderName,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}

class MessageService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static const String messagesCollection = 'messages';

  // Send a message
  Future<void> sendMessage(String text) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final message = Message(
      id: '',
      text: text,
      senderEmail: user.email ?? 'anonymous@example.com',
      senderName: user.displayName ?? 'Anonymous User',
      timestamp: DateTime.now(),
    );

    await _firestore
        .collection(messagesCollection)
        .add(message.toMap());
  }

  // Get messages stream ordered by timestamp
  Stream<List<Message>> getMessagesStream() {
    return _firestore
        .collection(messagesCollection)
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Message.fromFirestore(doc))
          .toList();
    });
  }

  // Delete a message (only if user is the sender)
  Future<void> deleteMessage(String messageId, String senderEmail) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');
    if (user.email != senderEmail) {
      throw Exception('You can only delete your own messages');
    }

    await _firestore
        .collection(messagesCollection)
        .doc(messageId)
        .delete();
  }
}
