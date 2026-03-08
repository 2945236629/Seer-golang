package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task1488;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_10295 extends BaseMapProcess
   {
      
      public function MapProcess_10295()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         Task1488.initForMap10295(this);
      }
      
      override public function destroy() : void
      {
         Task1488.destroy();
      }
   }
}

