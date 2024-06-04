/*
 PIOKA
 Dessins génératifs pour Flux (flux.bzh)
 Quimper, Dour Ru, 20231003 / emoc / pierre@lesporteslogiques.net
 Processing 4.0b2 @ kirin / Debian Stretch 9.5
 
 003 : tous les tracés graphiques se font dans un buffer (les classes tracent dans le buffer)
 004 / pioka : version définitive, les valeurs des différents presets ont été modifiées au fur et à mesure
 
 Interactions clavier
   's' pour enregistrer (en haute définition selon la valeur de SAVE_HIRES ci-dessous)
   'r' pour remlancer la génération d'une nouvelle image
 
 */
 
String emplacement = ""; // à conserver tel quel, utilisé pour la publication
boolean TESTMODE = true; // à conserver tel quel, utilisé pour la publication

boolean SAVE_HIRES = false; // Enregistrer en haute définition, pour impression, ou pas

// fonctions de dates pour l'export d'images de log
import java.util.Date;
import java.text.SimpleDateFormat;
String SKETCH_NAME = getClass().getSimpleName();
String fichier =  "colo_pioka.png";

// Paramètres principaux
int mode_courbe = 6;             //  /!\ PRESETS : changer cete valeur modifie le graphisme
PImage logo;
ArrayList courbes = new ArrayList();

color[] colors = {
  #FFFFFF  };

color[] colors2 = {   // couleurs secondaires, de contraste
  #FFFFFF  };
  
color[] colors3 = {
  #FFFFFF  };

PFont pixeltiny;
// Paramètres de dimensionnement et de buffer
// 40 x 60 @ 150 dpi : 2362 x 3543, arrondi à 2364 x 3544 (/4 : 591 x 886)
float mul = 2; // rapport entre la fenêtre d'affichage et la taille de buffer
PGraphics pg;

// Debug
//boolean SHOW_CONTROL = true; // passé en variable dans la classe
boolean SHOW_LEGEND = true;



void setup() {
  size(874, 1240); // A5 paysage 150 dpi
  init();          // à conserver, utilisé pour la publication
  //pg = createGraphics(2364,3544);
  pg = createGraphics(1748,2480);
  smooth();
  logo = loadImage("logo_flux.png");
  pixeltiny = loadFont("PixelTiny-48.vlw");
  initCourbes(mode_courbe);
}

void draw () {
  background(255);
  pg.beginDraw();
  pg.background(255);
  pg.endDraw();
  for (int i = 0; i < courbes.size(); i++) {
    Courbe s = (Courbe) courbes.get(i);
    
    pg.beginDraw();
    pg.strokeWeight(4);
    println("courbe " + i + " en cours");
    s.draw(pg);
    pg.endDraw();
    
  }
  
  // Signature
  pg.beginDraw();
  pg.fill(255);
  pg.rect(pg.width - (150 * mul) - 10, pg.height - (10 * mul) - 16, 216, 21);
  pg.fill(#5B0888);
  //String emoc = signature();
  //pg.textFont(pixeltiny, 36);
  //pg.text(emoc, pg.width - (150 * mul), pg.height - (10 * mul));
  pg.endDraw();
    
  /* image(logo, width-125 - 10, 10, 125, 42); // Typo flux */
  image(pg, 0, 0, width, height);
  
  
  // Votre code s'arrête ici!
  
  marges(); // ajout des marges, 4mm de blanc tout autour
  // fin de la partie graphique *************************  
  
  if (!TESTMODE) {
    saveFrame(emplacement + fichier);
    exit();
  }
  noLoop();
}

void initCourbes(int mode_courbe) {
  // Chacune de ces fonctions déclenchent des presets différents
  if (mode_courbe == 1) initCourbes1(mul);
  if (mode_courbe == 2) initCourbes2(mul);
  if (mode_courbe == 3) initCourbes3(mul);
  if (mode_courbe == 4) initCourbes4(mul);
  if (mode_courbe == 5) initCourbes5(mul);
  if (mode_courbe == 6) initCourbes6(mul);
  if (mode_courbe == 7) initCourbes7(mul);
  if (mode_courbe == 8) println("pas de presets pour le moment");
  if (mode_courbe == 9) println("pas de presets pour le moment");
}
/*
String signature() {
  Date now = new Date();
  SimpleDateFormat formater = new SimpleDateFormat("yyyyMMdd-HHmmss");
  return "emoc-" + formater.format(now) + "-ic" + mode_courbe;
}
*/

void keyPressed() {
  if (key == 's') {
    Date now = new Date();
    SimpleDateFormat formater = new SimpleDateFormat("yyyyMMdd_HHmmss");
    System.out.println(formater.format(now));
    saveFrame(SKETCH_NAME + "_" + formater.format(now) + "_ic" + mode_courbe + ".png");
    if (SAVE_HIRES) pg.save(SKETCH_NAME + "_" + formater.format(now) + "_HR_ic" + mode_courbe + ".png");
  }
  if (key == ' ') {
    // Relancer une génération en supprimant toutes les courbes
    for (int i = courbes.size() - 1; i >= 0; i--) {
      courbes.remove(i);
    }
    initCourbes(mode_courbe);
    redraw();
  }
}

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
