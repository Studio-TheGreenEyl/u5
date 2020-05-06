import processing.svg.*;
String date = year() +""+ nf(month(), 2) +""+ nf(day(), 2) +"_"+ nf(hour(), 2) +""+ nf(minute(), 2) +""+ nf(second(), 2);
String fn = "output_"+ date +".svg";
PGraphics svg = createGraphics(2480, 720, SVG, fn);
svg.beginDraw();
for(int i = 0; i<50; i++) {
  float x = random(0, svg.width);
  float y = random(0, svg.height);
  float l = random(0, svg.width + svg.height);
  svg.line(x, y, l, l);
}
svg.dispose();
svg.endDraw();
exit();
