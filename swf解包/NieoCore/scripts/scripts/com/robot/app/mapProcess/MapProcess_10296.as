package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1495;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_10296 extends BaseMapProcess
   {
      
      public function MapProcess_10296()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         TaskController_1495.initForMap10296(this);
      }
      
      override public function destroy() : void
      {
      }
   }
}

