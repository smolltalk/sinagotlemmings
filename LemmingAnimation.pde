class LemmingAnimation {
  PImage[] images;
  int imageCount;

  LemmingAnimation(String imagePrefix, int count) {
    imageCount = count;
    images = new PImage[imageCount];

    for (int i = 0; i < imageCount; i++) {
      // Use nf() to number format 'i' into four digits
      String filename = imagePrefix + nf(i, 1) + ".png";
      images[i] = loadImage(filename);
    }
  }

  int display(int frame, float xpos, float ypos) {
    image(images[frame], xpos, ypos);
    // Compute next frame
    frame = (frame+1) % imageCount;   
    return frame;
  }

  int getWidth() {
    return images[0].width;
  }

  int getHeight() {
    return images[0].height;
  }
}