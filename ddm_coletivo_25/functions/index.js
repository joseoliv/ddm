/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const {setGlobalOptions} = require("firebase-functions");
// const {onRequest} = require("firebase-functions/https");
// const logger = require("firebase-functions/logger");

// For cost control, you can set the maximum number of containers that can be
// running at the same time. This helps mitigate the impact of unexpected
// traffic spikes by instead downgrading performance. This limit is a
// per-function limit. You can override the limit for each function using the
// `maxInstances` option in the function's options, e.g.
// `onRequest({ maxInstances: 5 }, (req, res) => { ... })`.
// NOTE: setGlobalOptions does not apply to functions using the v1 API. V1
// functions should each use functions.runWith({ maxInstances: 10 }) instead.
// In the v1 API, each function can only serve one request per container, so
// this will be the maximum concurrent request count.
setGlobalOptions({maxInstances: 10});

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });


// functions/index.js
const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

const SEED_ADMINS = new Set([
  "fiP5NpKzjNUSBMbCbOXhVN4TqZH3", // José
]);

exports.makeAdmin = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", 
      "Only authenticated users can request this action.");
  }

  const callerUid = context.auth.uid;
  const hasClaim = context.auth.token.canAddUsers === true;
  const isSeed = SEED_ADMINS.has(callerUid);
  if (!hasClaim && !isSeed) {
    throw new functions.https.HttpsError("permission-denied", 
      "Only designated admin users can promote others.");
  }

  const targetUid = data && data.uid;
  if (!targetUid) {
    throw new functions.https.HttpsError("invalid-argument", 
      "The target user UID is required.");
  }

  try {
    await admin.auth().setCustomUserClaims(targetUid, { canAddUsers: true });
    await admin.auth().revokeRefreshTokens(targetUid);
    return { success: true, uid: targetUid };
  } catch (err) {
    console.error("makeAdmin failed:", err);
    throw new functions.https.HttpsError("internal", 
      "Failed to make user admin.");
  }
});
