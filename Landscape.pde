class Landscape {

  byte[][] objects = new byte[][]{
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1}, 
    {1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1}, 
    {1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1}, 
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}};

  PImage[] images;
  int[] treeObject = new int[20]; // réserve 20 "cases" de tableau

  Landscape() {

    for (int i = 0; i < treeObject.length; i++) { 
      treeObject[i] = (int) random(1, 4.99);  // on stock 20 random de 1 à 4
    }

    images = new PImage[9];
    images[0] = null; // reserved for later background
    images[1] = loadImage("A.gif"); // bord droit
    images[2] = loadImage("B.gif"); // entoure
    images[3] = loadImage("C.gif"); // bord gauche
    images[4] = loadImage("D.gif"); // isole
    images[5] = loadImage("E.gif"); // coeur
    images[6] = loadImage("arbre_01.png");
    images[7] = loadImage("arbre_02.png");
    images[8] = loadImage("arbre_03.png");
    
    generateLandscape();
  }

  void generateLandscape() {
    for (int y = 0; y < objects.length - 1; y ++)
      for (int x = 0; x < objects[0].length; x++)
      {
        if (objects[y][x] == 0) {
          continue;
        }
        boolean top = (y > 0 && objects[y - 1][x] > 0);
        // boolean bottom = (y < objects.length - 1 && objects[y + 1][x] > 1) || y == objects.length - 1;
        boolean left = (x > 0 && objects[y][x - 1] > 0) || x == 0;
        boolean right = (x < (objects[y].length - 1) && objects[y][x + 1] > 0) || x == (objects[y].length - 1);

        if (top) {
          // coeur
          objects[y][x] = 5;
        } else {
          if (left && right) {
            // entoure
            objects[y][x] = 2;
          } else if (left) {
            // bord droit
            objects[y][x] = 3;
          } else if (right) {
            // bord gauche
            objects[y][x] = 1;
          } else {
            // isolee
            objects[y][x] = 4;
          }
        }
      }
  }

  void display() {
    int r = 0;
    pushMatrix();
    translate(0, 4*40);
    for (int y = 0; y < objects.length; y ++)
      for (int x = 0; x < objects[0].length; x++)
      {
        int imageType = objects[y][x];
        switch(imageType) {
        case 0:
          continue;
        case 2:
          r = (r+1) % treeObject.length;
          int to = treeObject[r]; 
          switch (to) {
          case 1: 
          case 2: 
          case 3: 
            image(images[to + 5], x * 40, y * 40-images[to + 5].height);//rajout d'arbre
            break;
          default:
            break;
          }
          // No break to run default
        default :
          image(images[imageType], x * 40, y * 40);
        }
      }
  }

  boolean isWalkFree(int xpos, int ypos) {
    xpos = Math.max(0, Math.min(width-1, xpos));
    ypos = Math.max(0, Math.min(height-1, ypos));

    int x = xpos / 40;
    int y = Math.min(objects.length-1, ypos / 40); 

    return objects[y][x] == 0;
  }
}