package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task983;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_719 extends BaseMapProcess
   {
      
      public function MapProcess_719()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         Task983.initForMap719(this);
      }
      
      override public function destroy() : void
      {
         Task983.destroy();
         super.destroy();
      }
   }
}

