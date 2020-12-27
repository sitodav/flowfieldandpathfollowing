


boolean SHOW_ABSOLUTE = false;
boolean SHOW_NORMALS = false;
float FULL_SPEED = 15;
float MASS =  20;
float PATH_RAY = 19;
boolean ANIMATE = false;
ArrayList<AgentSpawner> spawners = new ArrayList<AgentSpawner>();
FlowField ff;

void setup()
{

  size(800, 800);
  background(255);
  ff = new FlowField(width, height, 15, 15 );
  ff.initVectors();
}

void draw()
{

  //background(255);
  fill(255, 215);
  rect(0, 0, width, height);
  ff._draw();
  if (null != spawners)
  {
    for (AgentSpawner spawner : spawners)
    {
      for (Agent agent : spawner.agents)
      {
        agent._draw();
      }
    }
  }

  if (  null != spawners)
  {


    for (AgentSpawner spawner : spawners)
    {
      spawner._draw();
      for (Agent agent : spawner.agents)
      {
        Path ffVectorPath = ff.lookupAbsoluteVectPath(agent.absolutePosition);

        PVector normalPredictedVector = agent.computeInternalState(ffVectorPath);

        if (PATH_RAY < normalPredictedVector.mag())
        {
          PVector target = agent.absolutePosition.get().add(normalPredictedVector);
          agent. updatePosition(target);
        } else 
        {
          PVector target = agent.relativeVelocity.get().add(agent.absolutePosition);
          agent.updatePosition(target);
        }
      }
    }
  }
}

void keyPressed()
{
  if (SHIFT == keyCode)
  {
    ff.initVectors();
  } else if (CONTROL == keyCode)
  {  
    spawners.add(new AgentSpawner(new PVector(mouseX, mouseY)));
  } else if (TAB == keyCode)
  {
    for (AgentSpawner spawner : spawners)
    {
      spawner.agents.add(new Agent(spawner.position.get(), MASS));
    }
  } else if (ENTER == keyCode)
  { 
    ANIMATE = !ANIMATE;
  }
}
void mousePressed()
{
}
