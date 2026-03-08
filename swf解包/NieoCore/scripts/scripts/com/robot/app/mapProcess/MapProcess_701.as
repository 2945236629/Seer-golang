package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task873;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_701 extends BaseMapProcess
   {
      
      public function MapProcess_701()
      {
         super();
      }
      
      override protected function init() : void
      {
         Task873.initForMap701(this);
      }
      
      override public function destroy() : void
      {
         Task873.destroy();
         super.destroy();
      }
   }
}

