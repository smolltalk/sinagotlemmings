/**
 * Animated Sprite (Shifty + Teddy)
 * by James Paterson. 
 * 
 * Press the mouse button to change animations.
 * Demonstrates loading, displaying, and animating GIF images.
 * It would be easy to write a program to display 
 * animated GIFs, but would not allow as much control over 
 * the display sequence and rate of display. 
 */
import java.util.Iterator;

PFont font;
PImage fond;


Landscape landscape;
LemmingAnimationSet animSet;
ArrayList<Lemming> lemmingList;
int nb_entrance = 0;
int nb_exit = 0;
int type = 0;
int frequency = 5;


void setup() {
  size(1280, 600);
  surface.setResizable(true);
  fond = loadImage("FOND_ETOILE.jpg");
  frameRate(12);
  landscape = new Landscape();
  animSet = new LemmingAnimationSet();
  lemmingList = new ArrayList();
  //lemmingList.add(new Lemming(animSet, landscape, 10, 0, nb_entrance, type));

  font = createFont("Arial", 20);
  textFont(font);
  fill(255);
  textAlign(CENTER, TOP);
}

void draw() {
  background(0);
  image(fond,0,0);
  landscape.display();
  for (Iterator<Lemming> iterator = lemmingList.iterator (); iterator.hasNext(); ) {
    Lemming lemming = iterator.next();
      if (lemming.isDead()){
        iterator.remove();
        if (lemmingList.isEmpty()){
          exit();
        }
      }else{
        lemming.display();
      }
  }

  /**    
   if (lemmingList.isEmpty()){
   exit();
   }
   */

  // Lemmings counter 
  int nb_actives_lemmings = lemmingList.size();

  textSize(20);
  text("Actifs " + nb_actives_lemmings, width/4, height-30);
  text("T Entrées " + (nb_entrance), (width/4)*2, height-30);
  text("T Sorties " + (nb_exit), (width/4)*3, height-30);
}

void mousePressed() {
  
  if (mouseButton == LEFT) {
    
    
    nb_entrance++;
    lemmingList.add(new Lemming(animSet, landscape, ((int) random(1,31)) * 40 + 20, 0, nb_entrance, type));
    type = (type+1) % frequency;
  
} else if (mouseButton == RIGHT) {

    if (!lemmingList.isEmpty()){
      nb_exit++;
      lemmingList.get(0).kill();
    }
  }
  
}