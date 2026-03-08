package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task789;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_10367 extends BaseMapProcess
   {
      
      public function MapProcess_10367()
      {
         super();
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
      
      override protected function init() : void
      {
         super.init();
         Task789.initTaskForMap507(this);
      }
      
      override public function setup() : void
      {
         super.setup();
      }
   }
}

