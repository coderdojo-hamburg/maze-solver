//Maze solver
PImage maze;
IntList x = new IntList();
IntList y = new IntList();
IntList parent = new IntList();
IntList blockedx = new IntList();
IntList blockedy = new IntList();
int ts = 5;
int goalx = 7;
int goaly = 1;
IntList wayx = new IntList();
IntList wayy = new IntList();
ArrayList<Boolean> blocked = new ArrayList();
boolean finish = false;
boolean wayfinish = false;
int g = 0;
void setup() {
  maze = loadImage("maze.jpg");
  size(500, 500);
  for (int xx = 0; xx < maze.width; xx++) {
    for (int yy = 0; yy < maze.height; yy++) {
      if (red(maze.pixels[xx+yy*maze.width]) < 10) {
        blockedx.append(xx);
        blockedy.append(yy);
      }
      if (red(maze.pixels[xx+yy*maze.width]) > 100 && green(maze.pixels[xx+yy*maze.width]) < 100) {
        x.append(xx);
        y.append(yy);
        parent.append(0);
      }
    }
  }
}

void draw() {
  frameRate(50);
  background(0);
  if (finish) {
    wayx.append(x.get(parent.get(g)));
    wayy.append(y.get(parent.get(g)));
    g = parent.get(g);
    println(wayx.size());
  } else {
  }
  for (int xx = 0; xx < width/ts; xx++) {
    for (int yy = 0; yy < height/ts; yy++) {
      noFill();
      noStroke();
      for (int i = 0; i < blockedx.size(); i++) {
        if (blockedx.get(i) == xx && blockedy.get(i) == yy) {
          fill(255, 0, 0);
        }
      }
      for (int i = 0; i < x.size(); i++) {
        if (x.get(i) == xx && y.get(i) == yy) {
          fill(255);
        }
        if (x.get(i) == goalx && y.get(i) == goaly && !finish) {

          g = i;
          finish = true;
        }
      }
      if (goalx == xx && goaly == yy) {
        fill(0, 255, 0);
      }
      for (int i = 0; i < wayx.size(); i++) {
        if (wayx.get(i) == xx && wayy.get(i) == yy) {
          fill(0, 0, 255);
        }
      }
      rect(xx*ts, yy*ts, ts, ts);
    }
  }
  int s = x.size();
  boolean ap = true;
  for (int l = 0; l < 60-frameRate; l++) {
    if (!finish) {
      for (int i = 0; i < s; i++) {
        if (blocked.size() < i+1) {
          ap = true;
          if (x.get(i)+1 < width/ts) {
            for (int o = 0; o < x.size(); o++) {
              if (x.get(o) == x.get(i)+1 && y.get(o) == y.get(i)) {
                ap = false;
              }
            }
            for (int o = 0; o < blockedx.size(); o++) {
              if (blockedx.get(o) == x.get(i)+1 && blockedy.get(o) == y.get(i)) {
                ap = false;
              }
            }
            if (ap) {
              parent.append(i);
              x.append(x.get(i)+1);
              y.append(y.get(i));
            }
            ap = true;
            if (y.get(i)+1 < height/ts) {
              for (int o = 0; o < x.size(); o++) {
                if (y.get(o) == y.get(i)+1 && x.get(o) == x.get(i)) {
                  ap = false;
                }
              }
              for (int o = 0; o < blockedx.size(); o++) {
                if (blockedx.get(o) == x.get(i) && blockedy.get(o) == y.get(i)+1) {
                  ap = false;
                }
              }
              if (ap) {
                parent.append(i);
                x.append(x.get(i));
                y.append(y.get(i)+1);
              }
            }
            ap = true;
            if (x.get(i)-1 > -1) {
              for (int o = 0; o < x.size(); o++) {
                if (x.get(o) == x.get(i)-1 && y.get(o) == y.get(i)) {
                  ap = false;
                }
              }
              for (int o = 0; o < blockedx.size(); o++) {
                if (blockedx.get(o) == x.get(i)-1 && blockedy.get(o) == y.get(i)) {
                  ap = false;
                }
              }
              if (ap) {
                parent.append(i);
                x.append(x.get(i)-1);
                y.append(y.get(i));
              }
            }
            ap = true;
            if (y.get(i) > 0) {
              for (int o = 0; o < x.size(); o++) {
                if (y.get(o) == y.get(i)-1 && x.get(o) == x.get(i)) {
                  ap = false;
                }
              }
              for (int o = 0; o < blockedx.size(); o++) {
                if (blockedx.get(o) == x.get(i) && blockedy.get(o) == y.get(i)-1) {
                  ap = false;
                }
              }
              if (ap) {
                parent.append(i);
                x.append(x.get(i));
                y.append(y.get(i)-1);
              }
            }
            blocked.add(true);
          }
        }
      }
    }
  }
}
