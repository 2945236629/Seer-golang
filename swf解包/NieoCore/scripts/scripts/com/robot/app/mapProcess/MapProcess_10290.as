package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task1462;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_10290 extends BaseMapProcess
   {
      
      public function MapProcess_10290()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         Task1462.initForMap10290(this);
      }
      
      override public function destroy() : void
      {
         Task1462.destroy();
      }
   }
}

