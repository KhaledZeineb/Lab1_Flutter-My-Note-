# 🔐 Configuration Base de Données Appwrite - Guide Complet

## 📋 Étape 3 : Schéma de Base de Données avec `user_id`

### 🎯 Configuration dans la Console Appwrite

#### 1️⃣ Accéder à votre Collection

1. Ouvrez la **Console Appwrite** : https://cloud.appwrite.io/console
2. Sélectionnez votre **Projet**
3. Allez dans **Databases** → Sélectionnez votre database
4. Cliquez sur votre **Collection** `notes`

---

#### 2️⃣ Créer l'attribut `user_id`

Dans l'onglet **Attributes**, cliquez sur **Add Attribute** :

```
┌─────────────────────────────────────────┐
│ Attribut Configuration                  │
├─────────────────────────────────────────┤
│ Type:         String                    │
│ Key:          user_id                   │
│ Size:         255                       │
│ Required:     ✅ Yes                    │
│ Default:      (empty)                   │
│ Array:        ❌ No                     │
│ Encrypted:    ❌ No                     │
└─────────────────────────────────────────┘
```

**Paramètres détaillés :**
- **Type** : `String` (pour stocker l'ID utilisateur)
- **Clé** : `user_id` (correspond exactement au code)
- **Taille** : `255` (suffisant pour un ID Appwrite)
- **Requis** : `Oui` ✅ (chaque note doit avoir un propriétaire)
- **Default** : Laissez vide
- **Tableau** : `Non` (une note = un utilisateur)

Cliquez sur **Create** pour sauvegarder.

---

#### 3️⃣ Créer l'attribut `text`

Si pas déjà créé, ajoutez aussi l'attribut pour le contenu :

```
┌─────────────────────────────────────────┐
│ Attribut Configuration                  │
├─────────────────────────────────────────┤
│ Type:         String                    │
│ Key:          text                      │
│ Size:         10000                     │
│ Required:     ✅ Yes                    │
│ Default:      (empty)                   │
│ Array:        ❌ No                     │
└─────────────────────────────────────────┘
```

---

#### 4️⃣ Créer un Index (Performance) 🚀

**Pourquoi un index ?**
- Améliore les performances des requêtes par `user_id`
- Essentiel quand vous avez beaucoup de notes

**Comment créer :**

1. Allez dans l'onglet **Indexes**
2. Cliquez sur **Create Index**

```
┌─────────────────────────────────────────┐
│ Index Configuration                     │
├─────────────────────────────────────────┤
│ Index Type:    Key                      │
│ Index ID:      user_id_index            │
│ Attributes:    user_id                  │
│ Order:         ASC                      │
└─────────────────────────────────────────┘
```

**Paramètres :**
- **Type** : `Key`
- **ID** : `user_id_index` (nom descriptif)
- **Attributes** : Sélectionnez `user_id`
- **Order** : `ASC` (croissant)

Cliquez sur **Create**.

---

## 🔐 Configuration des Permissions (SÉCURITÉ CRITIQUE)

### ⚠️ Pourquoi c'est important ?

Le filtrage côté client (`Query.equal('user_id', userId)`) **N'EST PAS SUFFISANT** pour la sécurité :
- Un utilisateur malveillant peut modifier le code client
- Il pourrait accéder aux notes d'autres utilisateurs
- **Solution** : Configurer les permissions Appwrite côté serveur

---

### 🛡️ Configuration Recommandée (Sécurisée)

#### Option A : Permissions par Document (RECOMMANDÉ) ✅

1. Allez dans **Settings** → **Permissions** de votre collection
2. **Décochez** "Document Security" si coché
3. Configurez les permissions suivantes :

```
┌────────────────────────────────────────────────────┐
│ Collection Permissions                             │
├────────────────────────────────────────────────────┤
│ Role: Any                                          │
│   ❌ Create   ❌ Read   ❌ Update   ❌ Delete      │
│                                                    │
│ Role: Users                                        │
│   ✅ Create   ❌ Read   ❌ Update   ❌ Delete      │
└────────────────────────────────────────────────────┘
```

4. Activez **"Document Security"** ✅
5. Les permissions seront définies par document lors de la création

---

#### Modifier `note_service.dart` pour ajouter les permissions

Ouvrez `lib/services/note_service.dart` et modifiez la méthode `addNote` :

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
      permissions: [
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

**Explication :**
- `Permission.read(Role.user(userId))` : Seul l'utilisateur propriétaire peut lire
- `Permission.update(Role.user(userId))` : Seul le propriétaire peut modifier
- `Permission.delete(Role.user(userId))` : Seul le propriétaire peut supprimer

---

#### Option B : Permissions Globales (SIMPLE mais moins sécurisé)

Si vous voulez une configuration plus simple (pour le développement) :

1. Allez dans **Settings** → **Permissions**
2. **Décochez** "Document Security"
3. Configurez :

```
┌────────────────────────────────────────────────────┐
│ Collection Permissions                             │
├────────────────────────────────────────────────────┤
│ Role: Users (authenticated users)                  │
│   ✅ Create   ✅ Read   ✅ Update   ✅ Delete      │
└────────────────────────────────────────────────────┘
```

⚠️ **ATTENTION** : Avec cette config, n'importe quel utilisateur authentifié peut accéder aux notes de tous les utilisateurs. Le filtrage par `user_id` dans le code est votre seule protection (côté client uniquement).

**Utilisez cette option UNIQUEMENT pour le développement/test.**

---

## 🧪 Tester la Configuration

### Test 1 : Vérifier l'attribut `user_id`

1. Dans la console Appwrite, allez dans votre collection
2. Cliquez sur **Documents**
3. Créez un document test manuellement :
```json
{
  "text": "Test note",
  "user_id": "test_user_123"
}
```
4. Vérifiez qu'il se crée sans erreur

---

### Test 2 : Tester depuis l'application

```powershell
# Lancer l'app
flutter run
```

**Procédure de test :**
1. Créez un compte utilisateur (User A)
2. Ajoutez 2-3 notes
3. Déconnectez-vous
4. Créez un autre compte (User B)
5. Ajoutez quelques notes
6. Vérifiez que User B ne voit PAS les notes de User A ✅

---

### Test 3 : Vérifier les permissions (si Option A)

Dans la console Appwrite :
1. Allez dans **Documents** de votre collection
2. Cliquez sur une note créée par l'app
3. Vérifiez la section **Permissions** :
```
✅ Read: user:[userId]
✅ Update: user:[userId]
✅ Delete: user:[userId]
```

---

## 📊 Schéma Final de la Collection

Votre collection `notes` doit avoir cette structure :

```
Collection: notes
├── Attributs:
│   ├── user_id (String, 255, Required) ✅
│   └── text (String, 10000, Required) ✅
│
├── Indexes:
│   └── user_id_index (user_id, ASC) ✅
│
└── Permissions:
    ├── Document Security: Enabled ✅
    └── Users: Create only
```

---

## 🔑 Concepts Clés Expliqués

### 1️⃣ Filtrage des Requêtes

```dart
Query.equal('user_id', userId)
```

**Ce que ça fait :**
- Crée une condition WHERE dans la requête
- Équivalent SQL : `SELECT * FROM notes WHERE user_id = 'userId'`
- Retourne uniquement les documents correspondants

**Pourquoi c'est important :**
- Évite de charger toutes les notes de tous les utilisateurs
- Réduit la bande passante et améliore les performances
- Première ligne de défense (mais pas suffisante seule)

---

### 2️⃣ Context Provider (Flutter)

```dart
final authProvider = Provider.of<AuthProvider>(context);
final userId = authProvider.user!.$id;
```

**Ce que ça fait :**
- Maintient l'état de l'utilisateur dans toute l'application
- Évite de passer l'utilisateur manuellement entre widgets
- Pattern de gestion d'état recommandé par Flutter

**Avantages :**
- Code plus propre et maintenable
- Réactivité automatique (UI se met à jour quand l'état change)
- Un seul point de vérité pour l'état utilisateur

---

### 3️⃣ Considérations de Sécurité 🔐

**❌ Filtrage côté client SEUL = DANGEREUX**
```dart
// Ceci peut être contourné par un attaquant
final notes = await _noteService.getNotes(userId);
```

**✅ Sécurité en profondeur (Defense in Depth)**
```
1. Filtrage côté client (Query.equal)
   ↓
2. Permissions Appwrite côté serveur
   ↓
3. Index pour performance
   ↓
4. Validation des données
```

**Règles de sécurité Appwrite :**
- Configurées côté serveur (immuables par le client)
- Vérifiées avant chaque opération
- Impossibles à contourner par le client

---

## ✅ Checklist de Configuration

Cochez chaque étape :

- [ ] ✅ Attribut `user_id` créé (String, 255, Required)
- [ ] ✅ Attribut `text` créé (String, 10000, Required)
- [ ] ✅ Index `user_id_index` créé
- [ ] ✅ Document Security activé
- [ ] ✅ Permissions configurées (Option A recommandée)
- [ ] ✅ Code `note_service.dart` mis à jour avec permissions
- [ ] ✅ Tests effectués avec 2 utilisateurs différents
- [ ] ✅ Vérification que les notes sont isolées par utilisateur

---

## 🚨 Erreurs Courantes et Solutions

### Erreur : "Missing required attribute: user_id"
**Cause :** L'attribut n'est pas marqué comme requis ou n'existe pas  
**Solution :** Vérifiez la configuration dans Console → Attributes

### Erreur : "Missing permissions"
**Cause :** Document Security activé mais permissions non définies  
**Solution :** Ajoutez le paramètre `permissions` dans `createDocument`

### Les utilisateurs voient les notes des autres
**Cause :** Permissions trop larges ou filtrage incorrect  
**Solution :** Vérifiez les permissions de collection et document

### Erreur : "Query failed on user_id"
**Cause :** Index manquant ou attribut mal configuré  
**Solution :** Créez l'index `user_id_index`

---

## 🎓 Ressources Complémentaires

- [Appwrite Permissions Documentation](https://appwrite.io/docs/permissions)
- [Appwrite Queries Documentation](https://appwrite.io/docs/databases#querying-documents)
- [Security Best Practices](https://appwrite.io/docs/security)

---

**Configuration terminée ! Votre app est maintenant sécurisée. 🔐✨**
