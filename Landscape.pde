class Landscape {

  byte[][] objects = new byte[][]{
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1}, 
    {1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1}, 
    {1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1}, 
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
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
    images[1] = loadImage("A.gif");
    images[2] = loadImage("B.gif");
    images[3] = loadImage("C.gif");
    images[4] = loadImage("D.gif");
    images[5] = loadImage("E.gif");
    images[6] = loadImage("arbre_01.png");
    images[7] = loadImage("arbre_02.png");
    images[8] = loadImage("arbre_03.png");
  }

  void display() {
    int r = 0;
    pushMatrix();
    translate(0, 4*40);
    for (int y = 0; y < objects.length; y ++)
      for (int x = 0; x < objects[0].length; x++)
      {


        if ((y-1 >= 0) && (y+1 < objects.length) && (x-1 >= 0) && (x+1 < objects[0].length)) {

          if ((objects[y][x] == 1) && (objects[y-1][x] == 0) && (objects[y][x-1] == 0) && (objects[y][x+1] == 0)) {
            image(images[4], x * 40, y * 40); //plateforme isolée
          } else if ((objects[y][x] == 1) && (objects[y-1][x] == 0) && (objects[y][x+1] == 0) && (objects[y][x-1] == 1)) {
            image(images[3], x * 40, y * 40); //bord droit
          } else if ((objects[y][x] == 1) && (objects[y-1][x] == 0) && (objects[y][x+1] == 1) && (objects[y][x-1] == 0)) {
            image(images[1], x * 40, y * 40); //bord gauche
          } else if ((objects[y][x] == 1) && (objects[y-1][x] == 0) && (objects[y][x+1] == 1) && (objects[y][x-1] == 1)) {
            image(images[2], x * 40, y * 40); //plateforme entourée
            r = (r+1) % treeObject.length;
            switch (treeObject[r]) {
            case 1: 
              image(images[6], x * 40, y * 40-images[6].height);//rajout d'arbre
              break;
            case 2: 
              image(images[7], x * 40, y * 40-images[7].height);//rajout d'arbre
              break;
            case 3: 
              image(images[8], x * 40, y * 40-images[8].height);//rajout d'arbre
              break;
            case 4: //rien!
              break;
            default:
              break;
            }
          } else if ((objects[y][x] == 1) && (objects[y-1][x] == 1)) {
            image(images[5], x * 40, y * 40); //cœur de plateforme
          }
        } else if (objects[y][x] == 1) {
          image(images[2], x * 40, y * 40); //si je suis su rmes bords de tableau
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