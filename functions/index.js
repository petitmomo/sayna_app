// functions/index.js
const functions = require("firebase-functions");
const admin = require("firebase-admin");
const sgMail = require("@sendgrid/mail");

admin.initializeApp();

// Définir votre clé API SendGrid
sgMail.setApiKey("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");

exports.sendEmailNotification = functions.firestore
  .document("reservations/{reservationId}")
  .onCreate((snap, context) => {
    const reservationData = snap.data();
    const userEmail = reservationData.emailClient; // Adresse e-mail de l'utilisateur
    const userName = reservationData.nomClient;
    const userFirstName = reservationData.prenomClient; // Nom de l'utilisateur pour personnaliser l'e-mail

    const msg = {
      to: userEmail,
      from: "sayna_app@gmail.com", // Remplacez par l'e-mail d'envoi
      subject: "Confirmation de votre réservation",
      text: `Bonjour ${userName},\n\nVotre réservation a bien été enregistrée. Merci de nous faire confiance.\n\nCordialement, L'équipe.`,
      html: `<strong>Bonjour ${userFirstName} ${userName},</strong><p>Votre réservation a bien été enregistrée. Merci de nous faire confiance.</p><p>Cordialement, L'équipe.</p>`,
    };

    // Envoi de l'email
    return sgMail.send(msg)
      .then(() => console.log("Email envoyé avec succès"))
      .catch((error) => console.error("Erreur lors de l'envoi de l'email:", error));
  });
