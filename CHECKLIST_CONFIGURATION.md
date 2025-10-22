# ✅ Checklist Configuration Appwrite - Notes App

## 🎯 Objectif
Configurer Appwrite pour que chaque utilisateur ne voie QUE ses propres notes avec sécurité côté serveur.

---

## 📋 PARTIE 1 : Configuration Console Appwrite

### Étape 1.1 : Créer le Projet (si pas fait)
- [ ] Aller sur https://cloud.appwrite.io/console
- [ ] Cliquer sur "Create Project"
- [ ] Nom du projet : `Notes App`
- [ ] Noter le **Project ID** : `dfrthnvdjhjh2dkch54cjo-khsz58djdnk`
- [ ] Noter l'**Endpoint** : `https://cloud.appwrite.io/v1`

---

### Étape 1.2 : Créer la Database
- [ ] Dans le projet → Cliquer sur "Databases"
- [ ] Cliquer sur "Create Database"
- [ ] Nom : `notes_database`
- [ ] Noter le **Database ID** : `notes_app_database_main_version_2025`

---

### Étape 1.3 : Créer la Collection
- [ ] Dans la database → Cliquer sur "Create Collection"
- [ ] Nom : `notes`
- [ ] Collection ID : (auto-généré)
- [ ] Noter le **Collection ID** : `notes_table_data_structure_v1_2025`

---

### Étape 1.4 : Créer l'Attribut `user_id`
- [ ] Dans la collection → Onglet "Attributes"
- [ ] Cliquer sur "Add Attribute"
- [ ] Choisir type : **String**
- [ ] Configuration :
  ```
  Attribute Key:  user_id
  Size:           255
  Required:       ✅ OUI (cocher la case)
  Array:          ❌ NON
  Default:        (laisser vide)
  ```
- [ ] Cliquer sur "Create"
- [ ] Attendre que le statut passe à "Available" ✅

---

### Étape 1.5 : Créer l'Attribut `text`
- [ ] Cliquer à nouveau sur "Add Attribute"
- [ ] Choisir type : **String**
- [ ] Configuration :
  ```
  Attribute Key:  text
  Size:           10000
  Required:       ✅ OUI (cocher la case)
  Array:          ❌ NON
  Default:        (laisser vide)
  ```
- [ ] Cliquer sur "Create"
- [ ] Attendre que le statut passe à "Available" ✅

---

### Étape 1.6 : Créer l'Index (Performance)
- [ ] Onglet "Indexes"
- [ ] Cliquer sur "Create Index"
- [ ] Configuration :
  ```
  Index Type:     Key
  Index ID:       user_id_index
  Attributes:     user_id (sélectionner dans la liste)
  Order:          ASC
  ```
- [ ] Cliquer sur "Create"
- [ ] Attendre que le statut passe à "Available" ✅

---

### Étape 1.7 : Configurer les Permissions 🔐 (CRITIQUE)
- [ ] Onglet "Settings"
- [ ] Section "Permissions"
- [ ] **ACTIVER** "Document Security" ☑
- [ ] Dans "Collection Permissions" :
  - [ ] Role : **Users** → Cocher uniquement **Create** ✅
  - [ ] Role : **Any** → Tout décocher ❌
- [ ] Cliquer sur "Update" pour sauvegarder

**Résultat attendu :**
```
✅ Document Security: Enabled
✅ Users: Create
❌ Any: (aucun droit)
```

---

## 💻 PARTIE 2 : Configuration du Code Flutter

### Étape 2.1 : Mettre à jour `appwrite_config.dart`
- [ ] Ouvrir `lib/config/appwrite_config.dart`
- [ ] Remplacer les 4 valeurs :

```dart
class AppwriteConfig {
  static final Client client = Client()
    ..setEndpoint('https://cloud.appwrite.io/v1')  // ⬅️ Votre endpoint
    ..setProject('VOTRE_PROJECT_ID')               // ⬅️ Étape 1.1
    ;

  static const String databaseId = 'VOTRE_DATABASE_ID';      // ⬅️ Étape 1.2
  static const String collectionId = 'VOTRE_COLLECTION_ID';  // ⬅️ Étape 1.3
}
```

- [ ] Sauvegarder le fichier

---

### Étape 2.2 : Vérifier `note_service.dart`
- [ ] Ouvrir `lib/services/note_service.dart`
- [ ] Vérifier que la méthode `addNote` contient les permissions :

```dart
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
      permissions: [  // ⬅️ VÉRIFIER QUE C'EST PRÉSENT
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
```

- [ ] Si les permissions ne sont pas là, elles ont déjà été ajoutées ✅

---

### Étape 2.3 : Installer les dépendances
- [ ] Ouvrir PowerShell dans le dossier du projet
- [ ] Exécuter :

```powershell
flutter pub get
```

- [ ] Attendre la fin (message "Got dependencies!")

---

### Étape 2.4 : Vérifier les erreurs
- [ ] Exécuter :

```powershell
flutter analyze
```

- [ ] Vérifier qu'il n'y a **aucune erreur critique** (uniquement des warnings sont OK)

---

## 🧪 PARTIE 3 : Tests de Sécurité

### Test 1 : Créer deux utilisateurs

#### Utilisateur A (Alice)
- [ ] Lancer l'app : `flutter run`
- [ ] Créer un compte :
  ```
  Email:    alice@test.com
  Password: Test1234!
  Name:     Alice
  ```
- [ ] Se connecter
- [ ] Créer 3 notes :
  - [ ] "Note A1"
  - [ ] "Note A2"
  - [ ] "Note A3"
- [ ] Vérifier que les 3 notes s'affichent ✅
- [ ] Se déconnecter

#### Utilisateur B (Bob)
- [ ] Créer un autre compte :
  ```
  Email:    bob@test.com
  Password: Test1234!
  Name:     Bob
  ```
- [ ] Se connecter
- [ ] Créer 2 notes :
  - [ ] "Note B1"
  - [ ] "Note B2"
- [ ] **Vérifier que Bob ne voit PAS les notes d'Alice** ✅
- [ ] Vérifier que Bob voit SEULEMENT ses 2 notes ✅

---

### Test 2 : Reconnecter Alice
- [ ] Se déconnecter (Bob)
- [ ] Se reconnecter avec Alice :
  ```
  Email:    alice@test.com
  Password: Test1234!
  ```
- [ ] **Vérifier qu'Alice voit toujours ses 3 notes** ✅
- [ ] **Vérifier qu'Alice ne voit PAS les notes de Bob** ✅

---

### Test 3 : Vérifier dans la Console Appwrite
- [ ] Aller dans Console Appwrite
- [ ] Databases → notes_database → notes → **Documents**
- [ ] Cliquer sur une note créée par Alice
- [ ] Vérifier la section **Permissions** :
  ```
  ✅ read("user:[userId_Alice]")
  ✅ update("user:[userId_Alice]")
  ✅ delete("user:[userId_Alice]")
  ```
- [ ] Faire de même pour une note de Bob
- [ ] Vérifier que les permissions contiennent **userId_Bob**

---

## 🎯 PARTIE 4 : Validation Finale

### Checklist de Validation
- [ ] ✅ Attributs créés (`user_id`, `text`)
- [ ] ✅ Index créé (`user_id_index`)
- [ ] ✅ Document Security activé
- [ ] ✅ Permissions configurées (Users: Create only)
- [ ] ✅ Code `appwrite_config.dart` mis à jour avec vos IDs
- [ ] ✅ Code `note_service.dart` contient les permissions
- [ ] ✅ `flutter pub get` exécuté sans erreur
- [ ] ✅ `flutter analyze` ne montre aucune erreur critique
- [ ] ✅ Test avec 2 utilisateurs : isolation confirmée ✅
- [ ] ✅ Vérification dans Console : permissions par document ✅

---

## 🚨 Résolution de Problèmes

### Problème 1 : Erreur "Missing required attribute: user_id"
**Cause :** L'attribut n'est pas marqué "Required"  
**Solution :**
- [ ] Console → Collection → Attributes
- [ ] Supprimer l'attribut `user_id`
- [ ] Le recréer avec "Required" ✅ coché

---

### Problème 2 : Utilisateur B voit les notes d'Alice
**Cause :** Document Security non activé OU permissions mal configurées  
**Solution :**
- [ ] Console → Collection → Settings → Permissions
- [ ] Vérifier que "Document Security" est ☑ activé
- [ ] Vérifier dans le code que les permissions sont bien définies dans `addNote`
- [ ] Supprimer toutes les notes existantes (créées sans permissions)
- [ ] Recréer des notes après avoir corrigé

---

### Problème 3 : Erreur "Permission denied" lors de la création
**Cause :** Permission "Create" non accordée aux Users  
**Solution :**
- [ ] Console → Collection → Settings → Permissions
- [ ] Role "Users" → Cocher **Create** ✅

---

### Problème 4 : Erreur "Undefined name 'AppwriteConfig'"
**Cause :** IDs non remplis dans `appwrite_config.dart`  
**Solution :**
- [ ] Retourner à l'Étape 2.1
- [ ] Remplir les 4 valeurs (endpoint, projectId, databaseId, collectionId)

---

## 📊 Résultat Attendu

### Structure finale dans Appwrite :

```
Project: Notes App
└── Database: notes_database
    └── Collection: notes
        ├── Attributes:
        │   ├── user_id (String, 255, Required) ✅
        │   └── text (String, 10000, Required) ✅
        ├── Indexes:
        │   └── user_id_index (user_id, ASC) ✅
        └── Permissions:
            ├── Document Security: Enabled ✅
            └── Users: Create ✅
```

### Code Flutter :
- ✅ `lib/config/appwrite_config.dart` : IDs remplis
- ✅ `lib/services/note_service.dart` : Permissions définies
- ✅ `lib/models/note_model.dart` : Modèle créé
- ✅ `lib/screens/notes_screen.dart` : Intégration Appwrite
- ✅ `lib/widgets/add_note_modal.dart` : Modal créé

---

## 🎉 Félicitations !

Si toutes les cases sont cochées, votre application est :
- ✅ **Fonctionnelle** : Création, lecture, suppression de notes
- ✅ **Sécurisée** : Isolation des données par utilisateur (serveur)
- ✅ **Performante** : Index sur user_id pour requêtes rapides
- ✅ **Testée** : Validation avec 2 utilisateurs

---

## 📚 Documents Complémentaires

Consultez aussi :
- `CONFIGURATION_APPWRITE.md` - Guide complet
- `CONFIGURATION_BDD_APPWRITE.md` - Configuration détaillée de la BDD
- `GUIDE_VISUEL_APPWRITE.md` - Diagrammes et schémas visuels

---

**🚀 Votre application Notes est prête à l'emploi !**

Date de configuration : _______________
Configuré par : _______________
