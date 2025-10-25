import 'package:cloud_functions/cloud_functions.dart';

Future<void> createUserAccounts() async {
  for (final email in emailStudents) {
    final password = email; // Set a default password or generate one
    try {
      await createNewUserByAdmin(email, password);
    } catch (e) {
      print('Error creating user for $email: $e');
    }
  }
}

// ... inside a method in your Flutter app, after an admin user has logged in ...

Future<void> makeUserAdminFromApp(String targetUserUid) async {
  try {
    // 1. Get a reference to your Cloud Function
    final callable = FirebaseFunctions.instance.httpsCallable(
        'makeAdmin'); // 'makeAdmin' is the name of your Cloud Function

    // 2. Call the Cloud Function, passing the UID of the user to be made admin
    final HttpsCallableResult result =
        await callable.call<Map<String, dynamic>>({
      'uid': targetUserUid,
    });

    // 3. Handle the response from the Cloud Function
    if (result.data['success'] == true) {
      print('Successfully requested to make user $targetUserUid admin.');
      // You might want to display a success message to the admin user
    } else {
      print(
          'Failed to make user $targetUserUid admin: ${result.data['error']}');
      // Display an error message
    }
  } on FirebaseFunctionsException catch (e) {
    print(
        'Cloud Function error: code=${e.code}, message=${e.message}, details=${e.details}');
    // Handle Cloud Function specific errors (e.g., permission denied)
  } catch (e) {
    print('General error calling Cloud Function: $e');
  }
}

Future<void> createNewUserByAdmin(String newEmail, String newPassword) async {
  try {
    // 1. Get a reference to your Cloud Function for creating users
    // Let's call this new Cloud Function 'createUserByAdmin'
    final callable =
        FirebaseFunctions.instance.httpsCallable('createUserByAdmin');

    // 2. Call the Cloud Function, passing the email and password for the new user
    final HttpsCallableResult result =
        await callable.call<Map<String, dynamic>>({
      'email': newEmail,
      'password': newPassword,
    });

    // 3. Handle the response from the Cloud Function
    if (result.data['success'] == true) {
      print('Successfully created new user: ${result.data['uid']}');
      // You might display a success message to your admin user
      // Optionally, you could get the new user's UID from result.data['uid'] if the function returns it
    } else {
      print('Failed to create new user: ${result.data['error']}');
      // Display an error message to the admin user
    }
  } on FirebaseFunctionsException catch (e) {
    print(
        'Cloud Function error: code=${e.code}, message=${e.message}, details=${e.details}');
    // Handle specific Cloud Function errors (e.g., unauthorized admin, weak password)
  } catch (e) {
    print('General error calling Cloud Function: $e');
  }
}

const List<String> emailStudents = [
  'alineriemer@estudante.ufscar.br',
  'beatrizbarbosa@estudante.ufscar.br',
  'brunoferraz@estudante.ufscar.br',
  'bruno.povliuk@estudante.ufscar.br',
  'caiojansen@estudante.ufscar.br',
  'erik.silva@estudante.ufscar.br',
  'felipe.bastos@estudante.ufscar.br',
  'fernandofa@estudante.ufscar.br',
  'fernandoaoki@estudante.ufscar.br',
  'fidelcsp@estudante.ufscar.br',
  'giovanamaciel@estudante.ufscar.br',
  'giuliaazeka@estudante.ufscar.br',
  'jhmcukier@estudante.ufscar.br',
  'joaoaveraldo@estudante.ufscar.br',
  'kaueago@estudante.ufscar.br',
  'leonardoprado@estudante.ufscar.br',
  'leonardosouza@estudante.ufscar.br',
  'lucaszito@estudante.ufscar.br',
  'lucaslfs@estudante.ufscar.br',
  'marcela.ferraz@estudante.ufscar.br',
  'marcus.caruso@estudante.ufscar.br',
  'matteo@estudante.ufscar.br',
  'mauricio.junior@estudante.ufscar.br',
  'nicolaspratis@estudante.ufscar.br',
  'pedro.nogueira@estudante.ufscar.br',
  'rafaelcvs@estudante.ufscar.br',
  'rafaelmp@estudante.ufscar.br',
  'thiago.fernandes@estudante.ufscar.br',
  'thiago.toyota@estudante.ufscar.br',
  'vscastro59@estudante.ufscar.br',
  'vinicius.rodrigues@estudante.ufscar.br',
  'wilker.ribeiro42@estudante.ufscar.br'
];
