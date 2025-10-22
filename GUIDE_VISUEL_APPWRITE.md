# 🎯 Configuration Appwrite - Guide Visuel Complet

## 📋 Vue d'ensemble de la configuration

```
┌─────────────────────────────────────────────────────────────┐
│                    APPWRITE CONSOLE                         │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  Project: Notes App                                         │
│  Project ID: [VOTRE_PROJECT_ID]                            │
│  Endpoint: https://cloud.appwrite.io/v1                    │
│                                                             │
│  ┌────────────────────────────────────────────────┐        │
│  │  📊 Database: notes_database                   │        │
│  │  Database ID: [VOTRE_DATABASE_ID]             │        │
│  │                                                │        │
│  │  ┌──────────────────────────────────────┐     │        │
│  │  │  📝 Collection: notes                 │     │        │
│  │  │  Collection ID: [VOTRE_COLLECTION_ID]│     │        │
│  │  │                                       │     │        │
│  │  │  Attributs:                           │     │        │
│  │  │  • user_id (String, 255, Required)   │     │        │
│  │  │  • text (String, 10000, Required)    │     │        │
│  │  │                                       │     │        │
│  │  │  Indexes:                             │     │        │
│  │  │  • user_id_index (user_id, ASC)      │     │        │
│  │  │                                       │     │        │
│  │  │  Permissions: Document Security       │     │        │
│  │  └──────────────────────────────────────┘     │        │
│  └────────────────────────────────────────────────┘        │
└─────────────────────────────────────────────────────────────┘
```

---

## 🔧 Étape par étape dans la Console Appwrite

### Étape 1 : Créer les Attributs

#### 1.1 Attribut `user_id`

**Navigation :** Console → Databases → [Votre Database] → [Collection notes] → **Attributes**

```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  Create Attribute: user_id           ┃
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
┃                                      ┃
┃  Attribute Type:                     ┃
┃    ⦿ String  ○ Integer  ○ Boolean   ┃
┃                                      ┃
┃  Attribute Key:                      ┃
┃  ┌────────────────────────────────┐  ┃
┃  │ user_id                        │  ┃
┃  └────────────────────────────────┘  ┃
┃                                      ┃
┃  Size (characters):                  ┃
┃  ┌────────────────────────────────┐  ┃
┃  │ 255                            │  ┃
┃  └────────────────────────────────┘  ┃
┃                                      ┃
┃  ☑ Required                          ┃
┃  ☐ Array                             ┃
┃  ☐ Encrypted                         ┃
┃                                      ┃
┃  Default Value: (leave empty)        ┃
┃                                      ┃
┃  [ Cancel ]      [ Create ✓ ]        ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

#### 1.2 Attribut `text`

```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  Create Attribute: text              ┃
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
┃                                      ┃
┃  Attribute Type:                     ┃
┃    ⦿ String  ○ Integer  ○ Boolean   ┃
┃                                      ┃
┃  Attribute Key:                      ┃
┃  ┌────────────────────────────────┐  ┃
┃  │ text                           │  ┃
┃  └────────────────────────────────┘  ┃
┃                                      ┃
┃  Size (characters):                  ┃
┃  ┌────────────────────────────────┐  ┃
┃  │ 10000                          │  ┃
┃  └────────────────────────────────┘  ┃
┃                                      ┃
┃  ☑ Required                          ┃
┃  ☐ Array                             ┃
┃  ☐ Encrypted                         ┃
┃                                      ┃
┃  [ Cancel ]      [ Create ✓ ]        ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

---

### Étape 2 : Créer l'Index

**Navigation :** Console → Collection → **Indexes** → Add Index

```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  Create Index                        ┃
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
┃                                      ┃
┃  Index Type:                         ┃
┃    ⦿ Key  ○ Fulltext  ○ Unique      ┃
┃                                      ┃
┃  Index ID:                           ┃
┃  ┌────────────────────────────────┐  ┃
┃  │ user_id_index                  │  ┃
┃  └────────────────────────────────┘  ┃
┃                                      ┃
┃  Attributes:                         ┃
┃  ┌────────────────────────────────┐  ┃
┃  │ [▼ Select] user_id             │  ┃
┃  └────────────────────────────────┘  ┃
┃                                      ┃
┃  Order:                              ┃
┃    ⦿ ASC  ○ DESC                     ┃
┃                                      ┃
┃  [ Cancel ]      [ Create ✓ ]        ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

**Résultat :** Index créé pour accélérer les requêtes par `user_id`

---

### Étape 3 : Configurer les Permissions 🔐

**Navigation :** Console → Collection → **Settings** → Permissions

#### Option A : Document Security (RECOMMANDÉ) ✅

```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  Collection Permissions                         ┃
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
┃                                                 ┃
┃  ☑ Document Security                            ┃
┃     └─ Enable document-level permissions        ┃
┃                                                 ┃
┃  Collection-Level Permissions:                  ┃
┃  ┌─────────────────────────────────────────┐   ┃
┃  │ Role: Any                                │   ┃
┃  │   ☐ Create  ☐ Read  ☐ Update  ☐ Delete │   ┃
┃  └─────────────────────────────────────────┘   ┃
┃                                                 ┃
┃  ┌─────────────────────────────────────────┐   ┃
┃  │ Role: Users                              │   ┃
┃  │   ☑ Create  ☐ Read  ☐ Update  ☐ Delete │   ┃
┃  └─────────────────────────────────────────┘   ┃
┃                                                 ┃
┃  ℹ️  With Document Security enabled:            ┃
┃     Individual document permissions will be     ┃
┃     defined when creating each document         ┃
┃                                                 ┃
┃  [ Save ]                                       ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

**Explication :**
- ✅ **Document Security activé** : Les permissions sont définies par document
- ✅ **Users : Create** : Les utilisateurs authentifiés peuvent créer des documents
- ❌ **Lecture/Modification/Suppression** : Définies au niveau document (voir code ci-dessous)

---

## 💻 Code avec Permissions de Sécurité

### Fichier : `lib/services/note_service.dart`

```dart
// services/note_service.dart
import 'package:appwrite/appwrite.dart';
import '../models/note_model.dart';
import '../config/appwrite_config.dart';

class NoteService {
  final Databases databases;

  NoteService() : databases = Databases(AppwriteConfig.client);

  // 📥 Récupérer les notes de l'utilisateur
  Future<List<Note>> getNotes(String userId) async {
    try {
      final response = await databases.listDocuments(
        databaseId: AppwriteConfig.databaseId,
        collectionId: AppwriteConfig.collectionId,
        queries: [
          Query.equal('user_id', userId) // ✅ Filtrage côté client
        ],
      );

      return response.documents.map((doc) => Note.fromJson(doc.data)).toList();
    } catch (e) {
      print('Error fetching notes: $e');
      return [];
    }
  }

  // ➕ Ajouter une note avec permissions
  Future<Note?> addNote(String text, String userId) async {
    try {
      final response = await databases.createDocument(
        databaseId: AppwriteConfig.databaseId,
        collectionId: AppwriteConfig.collectionId,
        documentId: ID.unique(),
        data: {
          'text': text,
          'user_id': userId
        },
        permissions: [
          // 🔐 SÉCURITÉ : Seul le propriétaire peut accéder
          Permission.read(Role.user(userId)),
          Permission.update(Role.user(userId)),
          Permission.delete(Role.user(userId)),
        ],
      );

      return Note.fromJson(response.data);
    } catch (e) {
      print('Error adding note: $e');
      return null;
    }
  }

  // ✏️ Modifier une note
  Future<Note?> updateNote(String noteId, String text) async {
    try {
      final response = await databases.updateDocument(
        databaseId: AppwriteConfig.databaseId,
        collectionId: AppwriteConfig.collectionId,
        documentId: noteId,
        data: {
          'text': text,
        },
      );

      return Note.fromJson(response.data);
    } catch (e) {
      print('Error updating note: $e');
      return null;
    }
  }

  // 🗑️ Supprimer une note
  Future<bool> deleteNote(String noteId) async {
    try {
      await databases.deleteDocument(
        databaseId: AppwriteConfig.databaseId,
        collectionId: AppwriteConfig.collectionId,
        documentId: noteId,
      );
      return true;
    } catch (e) {
      print('Error deleting note: $e');
      return false;
    }
  }
}
```

---

## 🔐 Diagramme de Sécurité

### Comment fonctionne la sécurité en profondeur ?

```
┌─────────────────────────────────────────────────────────┐
│  UTILISATEUR A crée une note                            │
└─────────────────────────────────────────────────────────┘
                       ↓
┌─────────────────────────────────────────────────────────┐
│  1. CLIENT FLUTTER (note_service.dart)                  │
│     • Envoie : text + userId_A                          │
│     • Définit permissions: user(userId_A)               │
└─────────────────────────────────────────────────────────┘
                       ↓
┌─────────────────────────────────────────────────────────┐
│  2. APPWRITE SERVEUR                                    │
│     • Vérifie authentification ✅                       │
│     • Vérifie permissions collection ✅                 │
│     • Crée document avec permissions ✅                 │
└─────────────────────────────────────────────────────────┘
                       ↓
┌─────────────────────────────────────────────────────────┐
│  3. BASE DE DONNÉES                                     │
│     Document créé:                                      │
│     {                                                   │
│       "$id": "abc123",                                  │
│       "text": "Ma note",                                │
│       "user_id": "userId_A",                            │
│       "$permissions": [                                 │
│         "read(\"user:userId_A\")",                      │
│         "update(\"user:userId_A\")",                    │
│         "delete(\"user:userId_A\")"                     │
│       ]                                                 │
│     }                                                   │
└─────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────┐
│  UTILISATEUR B essaie d'accéder à la note de A          │
└─────────────────────────────────────────────────────────┘
                       ↓
┌─────────────────────────────────────────────────────────┐
│  CLIENT FLUTTER tente de lire                           │
│  Query.equal('user_id', 'userId_B')                     │
└─────────────────────────────────────────────────────────┘
                       ↓
┌─────────────────────────────────────────────────────────┐
│  APPWRITE SERVEUR                                       │
│  • Vérifie permissions du document ❌                   │
│  • userId_B ≠ userId_A                                  │
│  • ACCÈS REFUSÉ ❌                                      │
└─────────────────────────────────────────────────────────┘
                       ↓
            🚫 Note non retournée
```

---

## 📝 Résumé de Configuration

### ✅ Ce qui doit être fait :

| Étape | Action | Statut |
|-------|--------|--------|
| 1 | Créer attribut `user_id` | ⬜ À faire |
| 2 | Créer attribut `text` | ⬜ À faire |
| 3 | Créer index `user_id_index` | ⬜ À faire |
| 4 | Activer Document Security | ⬜ À faire |
| 5 | Configurer permissions Users (Create) | ⬜ À faire |
| 6 | Code `note_service.dart` mis à jour | ✅ Fait |
| 7 | Tester avec 2 utilisateurs | ⬜ À faire |

---

## 🧪 Scénario de Test

### Test 1 : Isolation des données

```
User A (alice@test.com)         User B (bob@test.com)
       ↓                                ↓
   Se connecte                      Se connecte
       ↓                                ↓
   Crée 3 notes:                    Crée 2 notes:
   • "Note A1" ✅                   • "Note B1" ✅
   • "Note A2" ✅                   • "Note B2" ✅
   • "Note A3" ✅                    
       ↓                                ↓
   Voit 3 notes ✅                  Voit 2 notes ✅
       ↓                                ↓
   NE VOIT PAS les notes B ✅       NE VOIT PAS les notes A ✅
```

### Test 2 : Tentative d'accès non autorisé

```
1. User A crée note avec ID "note123"
2. User A se déconnecte
3. User B se connecte
4. User B essaie de lire "note123" directement
   → RÉSULTAT : Permission refusée ❌
5. User B essaie de modifier "note123"
   → RÉSULTAT : Permission refusée ❌
6. User B essaie de supprimer "note123"
   → RÉSULTAT : Permission refusée ❌
```

---

## 🎯 Commandes de Test

```powershell
# 1. Vérifier la configuration
flutter analyze

# 2. Lancer l'application
flutter run

# 3. Vérifier les logs Appwrite
# Allez dans Console Appwrite → Logs
# Observez les requêtes et vérifiez les permissions
```

---

## ✨ Votre configuration est maintenant prête !

Une fois ces étapes complétées, votre application sera :
- ✅ **Sécurisée** : Chaque utilisateur ne voit que ses notes
- ✅ **Performante** : Index sur `user_id` pour requêtes rapides
- ✅ **Conforme** : Permissions au niveau document et collection
- ✅ **Testée** : Isolation des données vérifiée

---

**🔐 Sécurité garantie côté serveur + Performance optimisée ! 🚀**
