
class Lemming {
  // Animations
  LemmingAnimationSet animSet;
  Landscape landscape;

  // Position
  int xpos;
  int ypos;

  int rateFactorX = 6;
  int rateFactorY = 10;
  int randomDirection = (int)random(0, 1.99);
  int xDirection = 1;
  int yDirection = 1;
  float godPirouette;

  // Frame
  LemmingAnimation currentAnim;
  int frame;
  int time = 0;

  // Entrance Counter Marks
  int nb_entrance;
  int type;

  LemmingBehaviour behaviour;

  // Wall Counter & Reading Time
  int wallCounter = 0;
  int wallCounterDelay = 0;
  int changeTypeCounter = 0;

  // Collision, CollisionReactionDelay, ReadingDuration
  int collisionCounter;
  int collisionReactionDelay;
  int behaviourDuration;

  // Killing effect
  int killXPos;
  int killYPos;

  Lemming(LemmingAnimationSet animSet, Landscape landscape, int xpos, int ypos, int nb_entrance, int type) {
    this.animSet = animSet;
    this.landscape = landscape;
    this.nb_entrance = nb_entrance;
    this.type = type;
    this.xpos = xpos;
    this.ypos = ypos;
    this.xDirection = randomDirection == 0 ? -1: 1;
    this.behaviour = LemmingBehaviour.WALK;
    initWalk();
  }

  int getWidth() {
    return currentAnim.getWidth();
  }

  int getHeight() {
    return currentAnim.getHeight();
  }

  void display() {
    display_new();
  }

  void display_new() {
    switch(behaviour) {
    case WALK : 
      walk();
      break;
    case SHRUG : 
      shrug();
      break;
    case READ :
      read();
      break;
    case DANCE :
      dance();
      break;
    case FALL : 
      fall();
      break;
    case CLIMB : 
      climb();
      break;
    case GET_UP : 
      getUp();
      break;             
    case DIE : 
      die();
      break;
    }

    // Display animation
    frame = currentAnim.display(frame, xpos - getWidth() / 2, ypos - getHeight() / 2);

    // Display ID Lemmings
    textSize(13);
    text(nb_entrance, xpos, ypos-(getHeight()/2)-20);
  }

  void initWalk() {
    behaviour = LemmingBehaviour.WALK;
    currentAnim = selectXDirectionAnimation(animSet.RIGHT, animSet.LEFT);
    collisionCounter = 0;
    collisionReactionDelay = 0;
    behaviourDuration = 0;
    frame = 0;
    // Align ypos on grid to avoid walking bogged down in wall
    ypos = (((int) (ypos / 40)) * 40) + (getHeight() / 2);
  }

  void walk() {
    // Empty under feets
    if (landscape.isWalkFree(xpos, ypos + getHeight() / 2) && landscape.isWalkFree((xpos - 12 * xDirection), ypos + getHeight() / 2)) {
      // Nothing under feets => start falling
      initFall();
      return;
    }
    // Landscape collision or screen collision
    boolean landscapeCollision = !landscape.isWalkFree(xpos + xDirection * getWidth() / 2, ypos); 
    if (landscapeCollision || ((xDirection == -1) && xpos < getWidth() / 2) || (xDirection == 1 && xpos > width-(getWidth() / 2))) {
      // Bing! A wall or a screen edge => Change direction
      // Am I hurting a wall? If I get some luck (1/4), I will climb it!
      if (landscapeCollision && ((int) random(0, 4) == 0)) {
        initClimb();
      } else {
        collisionCounter ++;      
        if (collisionCounter == 3) {
          collisionReactionDelay = (int) random(5, 30);
        }
        xDirection = -1 * xDirection; 
        currentAnim = selectXDirectionAnimation(animSet.RIGHT, animSet.LEFT);
      }
      return;
    }
    // Reaction after collision?    
    if (collisionReactionDelay > 0) {
      collisionReactionDelay --;
      if (collisionReactionDelay == 0) {
        switch((int) random(0, 3)) {
        case 0 :
          initShrug();
          break;
        case 1 :
          initRead();
          break;
        default :
          initDance();
          break;
        }
        return;
      }
    }

    // Else walk
    xpos += xDirection * rateFactorX;
  }

  void initShrug() {
    behaviour = LemmingBehaviour.SHRUG;
    currentAnim = animSet.SHRUG;
    behaviourDuration = (int) random(10, 60);
    frame = 0;
  }

  void shrug() {
    if (behaviourDuration == 0) {
      initWalk();
      return;
    }
    behaviourDuration --;
  }

  void initRead() {
    behaviour = LemmingBehaviour.READ;
    currentAnim = selectXDirectionAnimation(animSet.READ_D_R, animSet.READ_D_L);
    behaviourDuration = (int) random(10, 60);
    time = 0;
    frame = 0;
  }

  void read() {
    if (behaviourDuration == 0) {
      initWalk();
      return;
    }
    behaviourDuration --;
    switch(time) {
    case 6 :
      currentAnim = selectXDirectionAnimation(animSet.READ_R, animSet.READ_L);
      frame = 0;
      break;
    }
    time ++;
  }

  void initDance() {
    behaviour = LemmingBehaviour.DANCE;
    currentAnim = selectXDirectionAnimation(animSet.DANCE_D_R, animSet.DANCE_D_L);
    behaviourDuration = (int) random(10, 60);
    time = 0;
    frame = 0;
  }

  void dance() {
    if (behaviourDuration == 0) {
      initWalk();
      return;
    }
    behaviourDuration --;
    switch(time) {
    case 5 :
      currentAnim = selectXDirectionAnimation(animSet.DANCE_R, animSet.DANCE_L);
      frame = 0;
      break;
    }
    time ++;
  }


  void initFall() {
    behaviour = LemmingBehaviour.FALL;
    yDirection = 1;
    rateFactorY = 10;
    time = 0;
    currentAnim = selectXDirectionAnimation(animSet.FALL_R, animSet.FALL_L);
    frame = 0;
  }

  void fall() {
    if (!landscape.isWalkFree(xpos, ypos + getHeight() / 2)) {
      // Hoho! I am feeling something => Start walking
      initWalk();
      return;
    }
    // Else fall
    switch(time) {
    case 5 :
      rateFactorY = 5;
      currentAnim = selectXDirectionAnimation(animSet.PARA_D_R, animSet.PARA_D_L);
      frame = 0;
      break;
    case 9 :
      rateFactorY = 5;
      currentAnim = selectXDirectionAnimation(animSet.PARA_R, animSet.PARA_L);
      frame = 0;
      break;
    }
    ypos += yDirection * rateFactorY;
    time ++;
  }

  void initClimb() {
    behaviour = LemmingBehaviour.CLIMB;
    yDirection = -1;
    currentAnim = selectXDirectionAnimation(animSet.CLIMB_R, animSet.CLIMB_L);
    frame = 0;
    if (xDirection < 0) {
      xpos = (((int) (xpos / 40)) * 40) + (getWidth() / 2) - 4;
    } else {
      xpos = (((int) (xpos / 40)) * 40) + (getWidth() / 2) + 8;
    }
  }

  void climb() {
    // Is my head hurting something?
    if (!landscape.isWalkFree(xpos, ypos + (getHeight() / 2) * yDirection) || ypos < getHeight() / 2) {
      // Change direction and fall
      xDirection = -1 * xDirection;
      initFall();
      return;
    }
    // Is free
    if (landscape.isWalkFree(xpos + xDirection * getWidth() / 2, ypos)) {      
      initGetUp();
      return;
    }

    // Else climb
    ypos += yDirection  * 2;
  }

  void initGetUp() {
    behaviour = LemmingBehaviour.GET_UP;
    currentAnim = selectXDirectionAnimation(animSet.GET_UP_R, animSet.GET_UP_L);
    frame = 0;
    time = 0;
    ypos -= 2;
    if (xDirection < 0) {
      xpos = (((int) (xpos / 40)) * 40);
    } else {
      xpos = ((((int) (xpos / 40)) +1) * 40);
    }
  }

  void getUp() {
    // After one loop
    if (time == 7) {
      xpos = xpos + xDirection * getWidth() / 2;
      initWalk();
      return;
    }
    time ++;
  }

  void kill() {
    behaviour = LemmingBehaviour.DIE;
    currentAnim = selectXDirectionAnimation(animSet.FALL_R, animSet.FALL_L);
    godPirouette = 0;
    killXPos = xpos;
    killYPos = ypos;
    frame = 0;
  }

  boolean isDead() {
    return (xpos < 0 || ypos > height);
  }  

  boolean isDying() {
    return (behaviour == LemmingBehaviour.DIE);
  }

  void die() {
    xpos = killXPos - ((int) godPirouette);
    ypos = killYPos + ((int) ((godPirouette - 110) * (godPirouette - 110) / 100) - 120) ; 
    godPirouette += 10;
  }

  LemmingAnimation selectXDirectionAnimation(LemmingAnimation r, LemmingAnimation l) {
    return xDirection == 1 ? r : l;
  }
}