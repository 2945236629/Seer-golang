package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_3015;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_10536 extends BaseMapProcess
   {
      
      public function MapProcess_10536()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         TasksManager.getProStatusList(3015,function(param1:Array):void
         {
            if(Boolean(param1[0]) && !param1[1])
            {
               TaskController_3015.pro2();
            }
            else if(Boolean(param1[1]) && !param1[2])
            {
               TaskController_3015.pro3();
            }
            else if(Boolean(param1[2]) && !param1[3])
            {
               TaskController_3015.pro4();
            }
         });
      }
   }
}

