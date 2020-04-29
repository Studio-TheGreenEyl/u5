class Settings{
  String fn;
  JSONObject settings;
  Settings() {
  }
  
  void load(String s) {
    JSONObject settings = loadJSONObject(s);
    play = settings.getBoolean("play");
    flip = settings.getBoolean("flip");
    offline = settings.getBoolean("offline");
    debug = settings.getBoolean("debug");
    rotate = settings.getBoolean("rotate");
    draw = settings.getBoolean("draw"); 
    redraw = settings.getBoolean("redraw"); 
    invert = settings.getBoolean("invert");
    deployed = settings.getBoolean("deployed");
   
    sliderBrightness = settings.getFloat("sliderBrightness");
    tempBrightness = sliderBrightness;
    
    introDuration = settings.getInt("introDuration")*1000;
    introAmount = settings.getInt("introAmount");
    theFrameRate = settings.getInt("frameRate");
    //frameRate(theFrameRate);
    tempFrameRate = theFrameRate;
    frameDelta = theFrameRate == 0 ? 0 : 1000.0 / theFrameRate;
    
    originX = settings.getInt("originX");
    MANIFEST_WIDTH = settings.getInt("MANIFEST_WIDTH");
    MANIFEST_HEIGHT = settings.getInt("MANIFEST_HEIGHT");
    linePixelPitch = settings.getInt("linePixelPitch");
    state = settings.getInt("state");
    tempState = state;
    
    fileName = settings.getString("fileName");
  }
}
