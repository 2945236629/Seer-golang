package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task1434;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_10285 extends BaseMapProcess
   {
      
      public function MapProcess_10285()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         Task1434.initForMap10285(this);
      }
      
      override public function destroy() : void
      {
         Task1434.destroy();
      }
   }
}

