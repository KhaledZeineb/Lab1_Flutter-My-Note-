# 📝 Configuration Appwrite pour Notes App

## ✅ Fichiers créés/modifiés

### Fichiers créés :
1. ✅ `lib/models/note_model.dart` - Modèle de données Note
2. ✅ `lib/widgets/add_note_modal.dart` - Modal d'ajout de note
3. ✅ `lib/widgets/note_item.dart` - Widget d'affichage d'une note
4. ✅ `lib/config/appwrite_config.dart` - Configuration Appwrite (à compléter)

### Fichiers modifiés :
1. ✅ `lib/screens/notes_screen.dart` - Mis à jour avec intégration Appwrite
2. ✅ `lib/services/note_service.dart` - Complété avec méthodes update/delete
3. ✅ `lib/services/auth_service.dart` - Corrigé `createEmailPasswordSession`
4. ✅ `lib/navigation/auth_navigator.dart` - Retiré référence à note_edit_screen

---

## 🔧 Configuration Appwrite à compléter

### 1️⃣ Créer votre projet Appwrite

**Option A : Appwrite Cloud (recommandé)**
1. Allez sur https://cloud.appwrite.io/console
2. Créez un compte (gratuit)
3. Créez un nouveau projet (ex: "Notes App")
4. Notez les informations suivantes :
   - **Endpoint** : `https://cloud.appwrite.io/v1`
   - **Project ID** : ex: `67abc123def456789` (visible dans Settings)

**Option B : Appwrite auto-hébergé**
1. Installez Appwrite localement : https://appwrite.io/docs/installation
2. Notez votre endpoint : ex: `http://localhost/v1`
3. Créez un projet et notez son ID

---

### 2️⃣ Créer la base de données

Dans votre console Appwrite :

1. **Créez une Database** :
   - Allez dans "Databases" → "Create Database"
   - Nom : `notes_database` (ou autre)
   - Notez le **Database ID** (ex: `675abc123`)

2. **Créez une Collection** :
   - Dans votre database → "Create Collection"
   - Nom : `notes`
   - Notez le **Collection ID** (ex: `notes_collection`)

3. **Ajoutez les attributs** :
   - `text` → Type: String, Taille: 1000, Requis ✅
   - `user_id` → Type: String, Taille: 255, Requis ✅

4. **Configurez les permissions** :
   - Settings → Permissions
   - Ajoutez : **"Any authenticated user"** avec :
     - ✅ Create
     - ✅ Read
     - ✅ Update
     - ✅ Delete

   **OU** pour plus de sécurité (recommandé) :
   - Role: **Users** → Create, Read, Update, Delete
   - Ajoutez un filtre sur `user_id` (voir doc Appwrite)

---

### 3️⃣ Mettre à jour `lib/config/appwrite_config.dart`

Ouvrez le fichier et remplacez :

```dart
class AppwriteConfig {
  static final Client client = Client()
    ..setEndpoint('https://cloud.appwrite.io/v1')  // ⬅️ VOTRE ENDPOINT
    ..setProject('67abc123def456789')              // ⬅️ VOTRE PROJECT ID
    ;

  // ⬇️ Remplacez par vos IDs
  static const String databaseId = '675abc123';    // ⬅️ VOTRE DATABASE ID
  static const String collectionId = 'notes_collection'; // ⬅️ VOTRE COLLECTION ID
}
```

---

### 4️⃣ Configurer l'authentification

Dans votre console Appwrite → **Auth** :

1. Activez **Email/Password** (si pas déjà fait)
2. (Optionnel) Configurez les paramètres :
   - Session Length
   - Password History
   - Email Templates

---

## 🚀 Tester l'application

### 1. Installer les dépendances
```powershell
flutter pub get
```

### 2. Vérifier qu'il n'y a pas d'erreurs
```powershell
flutter analyze
```

### 3. Lancer l'application
```powershell
flutter run
```

---

## 📱 Flux d'utilisation

1. **Inscription/Connexion** :
   - Créez un compte ou connectez-vous
   - L'utilisateur sera authentifié via Appwrite

2. **Créer une note** :
   - Cliquez sur le bouton `+`
   - Entrez votre texte
   - La note sera sauvegardée dans Appwrite

3. **Supprimer une note** :
   - Cliquez sur l'icône 🗑️ sur une note
   - Confirmer la suppression

4. **Rafraîchir** :
   - Tirez vers le bas (Pull to Refresh) pour recharger les notes

---

## ⚠️ Avertissements (non-bloquants)

Les warnings suivants sont présents mais n'empêchent pas l'exécution :

- `avoid_print` : Remplacer `print()` par un logger en production
- `use_build_context_synchronously` : Vérifier le contexte après `async`
- `deprecated_member_use` : Certaines méthodes Appwrite sont dépréciées (mais fonctionnent encore)

---

## 🔍 Résolution de problèmes

### Erreur : "Target of URI doesn't exist: 'appwrite_config.dart'"
✅ **Solution** : Le fichier a été créé dans `lib/config/appwrite_config.dart`

### Erreur : "createEmailSession is not defined"
✅ **Solution** : Corrigé → utilise maintenant `createEmailPasswordSession`

### Erreur : "Appwrite connection failed"
- ❌ Vérifiez votre endpoint (Cloud ou local)
- ❌ Vérifiez votre Project ID
- ❌ Si local : vérifiez que le serveur Appwrite tourne

### Erreur : "Permission denied"
- ❌ Vérifiez les permissions de votre collection
- ❌ Ajoutez "Any authenticated user" avec droits Create/Read/Update/Delete

---

## 📚 Ressources

- [Documentation Appwrite](https://appwrite.io/docs)
- [Flutter SDK Appwrite](https://appwrite.io/docs/sdks#flutter)
- [Tutoriels Appwrite](https://appwrite.io/docs/tutorials)

---

## ✨ Prochaines étapes (optionnel)

1. Ajouter l'édition de notes
2. Ajouter la recherche de notes
3. Ajouter des catégories/tags
4. Améliorer l'UI avec animations
5. Ajouter la synchronisation offline

---

**Bon développement ! 🚀**
