package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task1447;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_10286 extends BaseMapProcess
   {
      
      public function MapProcess_10286()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         Task1447.initForMap10286(this);
      }
      
      override public function destroy() : void
      {
         Task1447.destroy();
      }
   }
}

