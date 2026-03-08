package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_466 extends BaseMapProcess
   {
      
      public function MapProcess_466()
      {
         super();
      }
      
      override protected function init() : void
      {
         Task570.initTask_466(this);
      }
      
      override public function destroy() : void
      {
         Task570.destory();
      }
   }
}

