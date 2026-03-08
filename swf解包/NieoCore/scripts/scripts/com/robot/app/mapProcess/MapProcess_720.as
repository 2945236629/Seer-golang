package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task983;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_720 extends BaseMapProcess
   {
      
      public function MapProcess_720()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         Task983.initForMap720(this);
      }
      
      override public function destroy() : void
      {
         Task983.destroy();
         super.destroy();
      }
   }
}

