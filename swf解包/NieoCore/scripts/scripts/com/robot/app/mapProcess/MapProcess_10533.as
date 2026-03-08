package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_3013;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_10533 extends BaseMapProcess
   {
      
      public function MapProcess_10533()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         TasksManager.getProStatusList(3013,function(param1:Array):void
         {
            if(Boolean(param1[2]) && !param1[3])
            {
               TaskController_3013.pro4();
            }
         });
      }
   }
}

