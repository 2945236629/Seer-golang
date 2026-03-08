package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task1453;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_10289 extends BaseMapProcess
   {
      
      public function MapProcess_10289()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         Task1453.initForMap10289(this);
      }
      
      override public function destroy() : void
      {
         Task1453.destroy();
      }
   }
}

