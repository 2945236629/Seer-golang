package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task1477;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_10293 extends BaseMapProcess
   {
      
      public function MapProcess_10293()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         Task1477.initForMap10293(this);
      }
      
      override public function destroy() : void
      {
         Task1477.destroy();
      }
   }
}

