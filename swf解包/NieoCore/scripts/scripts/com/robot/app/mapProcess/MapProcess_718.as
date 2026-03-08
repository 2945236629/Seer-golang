package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task988;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_718 extends BaseMapProcess
   {
      
      public function MapProcess_718()
      {
         super();
      }
      
      override protected function init() : void
      {
         Task988.initForMap718(this);
      }
      
      override public function destroy() : void
      {
         Task988.destroy();
         super.destroy();
      }
   }
}

