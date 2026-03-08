package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task1476;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_10291 extends BaseMapProcess
   {
      
      public function MapProcess_10291()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         Task1476.initForMap10291(this);
      }
      
      override public function destroy() : void
      {
         Task1476.destroy();
      }
   }
}

