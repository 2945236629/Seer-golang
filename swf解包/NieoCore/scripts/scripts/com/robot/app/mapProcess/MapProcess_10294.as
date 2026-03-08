package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task1480;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_10294 extends BaseMapProcess
   {
      
      public function MapProcess_10294()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         Task1480.initForMap10294(this);
      }
      
      override public function destroy() : void
      {
         Task1480.destroy();
      }
   }
}

