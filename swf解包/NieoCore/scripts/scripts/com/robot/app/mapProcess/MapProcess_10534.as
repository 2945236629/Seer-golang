package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_3015;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_10534 extends BaseMapProcess
   {
      
      public function MapProcess_10534()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         if(TasksManager.getTaskStatus(3015) == TasksManager.UN_ACCEPT)
         {
            TasksManager.accept(3015);
         }
         TasksManager.getProStatusList(3015,function(param1:Array):void
         {
            if(!param1[0])
            {
               TaskController_3015.pro1();
            }
         });
      }
   }
}

