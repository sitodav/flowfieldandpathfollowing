class FlowField
{
  PVector[][] vectors;
  float _width, _height, colw, colh, ncols, nrows;

  public FlowField(float _width, float _height, float colw, float colh)
  {
    this._width = _width; 
    this._height = _height; 
    this.colw = colw; 
    this.colh = colh;
    this.ncols = _width / colw;
    this.nrows = _height / colh;
    vectors = new PVector[(int)nrows][(int)ncols];

    initVectors();
  }

  public void initVectors()
  {
    for (int i = 0; i< vectors.length; i++)
    {
      for (int j = 0; j< vectors[i].length; j++)
      {
        vectors[i][j] = new PVector(mouseX-j*colw, mouseY-i*colh);
        vectors[i][j].normalize();
        vectors[i][j].mult(colw);
      }
    }
  }


  public void _draw()
  {


    for (int i = 0; i< vectors.length; i++)
    {
      for (int j = 0; j< vectors[i].length; j++)
      {

        stroke(0, 200);


        pushMatrix();
        translate(j*colw, i*colh);
        line(0, 0, vectors[i][j].x, vectors[i][j].y);  
        fill(255, 0, 0,200);
        ellipse(vectors[i][j].x, vectors[i][j].y, 2, 2);
        popMatrix();
      }
    }
  }

  public PVector lookupRelativeVect(PVector lookup) {

    int xIdx = int(constrain(lookup.x/colw, 0, ncols-1));
    int yIdx = int(constrain(lookup.y/colh, 0, nrows-1));
     
    return vectors[yIdx][xIdx];
  }
  
   public Path lookupAbsoluteVectPath(PVector lookup) {

    int xIdx = int(constrain(lookup.x/colw, 0, ncols-1));
    int yIdx = int(constrain(lookup.y/colh, 0, nrows-1));
    PVector ffVect = lookupRelativeVect(lookup).get();
    PVector absoluteStart = new PVector(xIdx * colw,yIdx*colh);
    PVector absoluteEnd = absoluteStart.get().add(ffVect);//.normalize().mult(colw);
    Path pathVect = new Path(absoluteStart,absoluteEnd);
    
    
    return pathVect;
  }
}
