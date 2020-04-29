static final int NONE = 0;
static final int DEMO1 = 1;
static final int DEMO2 = 2;

static final int SETUP = 99;

int state = SETUP;

static final String[] stateNames = {
  "Video Loop", "Atmen", "Lichtstreifen",
  "Hochwandern", "Soundreaktiv", "Perlin",
  "Flocking", "PingPong", "H. Wellen",
  "V. Wellen", "Aufwaerts", "Statische Bilder"
};

String getStateName(int state) {
  return stateNames[state];
}

void stateMachine(int state) {
  
   switch(state) {
    case SETUP:
      // load JSON Settings
      // load Vector file
      // 
    break;
   }
}
