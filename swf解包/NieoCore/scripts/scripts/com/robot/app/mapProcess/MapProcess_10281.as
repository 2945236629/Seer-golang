package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task1438;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_10281 extends BaseMapProcess
   {
      
      public function MapProcess_10281()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         Task1438.initForMap10281(this);
      }
      
      override public function destroy() : void
      {
         Task1438.destroy();
      }
   }
}

