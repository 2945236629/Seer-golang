package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task961;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_715 extends BaseMapProcess
   {
      
      public function MapProcess_715()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         Task961.initForMap715(this);
      }
      
      override public function destroy() : void
      {
         Task961.destroy();
         super.destroy();
      }
   }
}

