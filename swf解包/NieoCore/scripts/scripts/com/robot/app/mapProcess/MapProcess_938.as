package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_938;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_938 extends BaseMapProcess
   {
      
      public function MapProcess_938()
      {
         super();
      }
      
      override protected function init() : void
      {
         TaskController_938.initSPT(this);
      }
      
      override public function destroy() : void
      {
      }
   }
}

