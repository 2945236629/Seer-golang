package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_3013;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_10531 extends BaseMapProcess
   {
      
      public function MapProcess_10531()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         if(TasksManager.getTaskStatus(3013) == TasksManager.UN_ACCEPT)
         {
            TasksManager.accept(3013);
         }
         TasksManager.getProStatusList(3013,function(param1:Array):void
         {
            if(!param1[0])
            {
               TaskController_3013.pro1();
            }
         });
      }
   }
}

