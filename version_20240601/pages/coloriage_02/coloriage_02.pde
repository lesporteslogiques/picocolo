/*
  Squelette de code pour créer une illustration au format A5, portrait à 150 dpi
  Cours code créatif / EDNA, novembre 2019 / pierre@lesporteslogiques.net
  'espace' pour redessiner une image
  's' pour enregistrer l'image de la fenêtre au format png
 */

String emplacement = ""; // à conserver tel quel, utilisé pour la publication
boolean TESTMODE = true; // à conserver tel quel, utilisé pour la publication

String fichier =  "coloriage1.png"; // <- à remplacer par vos noms et prénoms (sans accents, espaces, maj)

// Quelques variables pour placer les formes : 
float x, y;    // coordonnées x,y 
float d;       // diametre  
float a;       // angle de départ (en degrés)
int s;         // sommets

float m = 24; // 24 px = 4 mm à 150 dpi

void setup() {
  size(874, 1240); // A5 paysage 150 dpi
  init();          // à conserver, utilisé pour la publication
}

void draw() {
  
  // début de la partie graphique ***********************
  
  // Votre code commence ici!
  
  background(255);
  stroke(0);

  for (int i = 0; i < 6; i++) {

    d = (1+random(40)) * 10;
    x = random(d + m, width - d - m);
    y = random(d + m, height - d - m);
    s = (1 + int(random(65)) ) * 4;
    splash(x, y, d, s, (random(360)) );

    d = (1 + random(12) ) * 10;
    x = random(d + m, width - d - m);
    y = random(d + m, height - d - m);
    s = ( 2 + int(random(23)) ) * 2;
    regular(x, y, d, s, (random(360)) );

    d = (1 + random(8) ) * 10;
    x = random(d + m, width - d - m);
    y = random(d + m, height - d - m);
    s = ( 2 + int(random(13)) ) * 2;
    blobi(x, y, d, s, (random(360)) );

    d = (1 + random(8) ) * 4;
    x = random(d + m, width - d - m);
    y = random(d + m, height - d - m);
    s = 3 + int(random(33));
    patrick(x, y, d, s, (random(360)) );

    d = (1 + random(12) ) * 10;
    x = random(d + m, width - d - m);
    y = random(d + m, height - d - m);
    s = ( 2 + int(random(23)) ) * 2;
    pilou(x, y, d, s, (random(360)) );
  }
   
  // Votre code s'arrête ici!
  
  marges(); // ajout des marges, 4mm de blanc tout autour
  // fin de la partie graphique *************************  
  
  if (!TESTMODE) {
    saveFrame(emplacement + fichier);
    exit();
  }
  noLoop();
}

void keyPressed() {
  if (key == ' ') redraw();
  if (key == 's') saveFrame();
}



// Fonction utilisée pour la publication à conserver telle quelle

void init() {
  if (args != null) {
    println(args.length);
    for (int i = 0; i < args.length; i++) {
      println(args[i]);
    }
    fichier = args[0];
    emplacement = args[1];
    if (args[2].equals("0")) TESTMODE = false;
    else TESTMODE = true;
    println("fichier : " + fichier);
    println("emplacement : " + emplacement);
    println("testmode : " + TESTMODE);
    println(fichier + " en cours");
  } else {
    println("args == null");
  }
}

// Fonction pour ajouter des marges ******************************
void marges() {
  colorMode(RGB);
  fill(255);
  stroke(255);
  rect(0, 0, width, 24);         // haut
  rect(0, height-24, width, 24); // bas
  rect(0, 0, 24, height);        // gauche
  rect(width-24, 0, 24, height); // droite
}
