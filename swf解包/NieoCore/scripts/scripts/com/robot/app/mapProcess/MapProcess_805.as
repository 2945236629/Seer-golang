package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task1312;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_805 extends BaseMapProcess
   {
      
      public function MapProcess_805()
      {
         super();
      }
      
      override protected function init() : void
      {
         Task1312.initForMap805(this);
      }
      
      override public function destroy() : void
      {
         Task1312.destroy();
      }
   }
}

