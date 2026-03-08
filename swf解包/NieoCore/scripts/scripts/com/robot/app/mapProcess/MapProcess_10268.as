package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task1429;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_10268 extends BaseMapProcess
   {
      
      public function MapProcess_10268()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         Task1429.initForMap10268(this);
      }
      
      override public function destroy() : void
      {
         Task1429.destroy();
      }
   }
}

