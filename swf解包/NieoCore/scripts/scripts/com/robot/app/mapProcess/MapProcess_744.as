package com.robot.app.mapProcess
{
   import com.robot.app.mapProcess.control.CourageTestActivity;
   import com.robot.app.task.taskscollection.Task1123;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_744 extends BaseMapProcess
   {
      
      public function MapProcess_744()
      {
         super();
      }
      
      override protected function init() : void
      {
         if(TasksManager.getTaskStatus(1123) == TasksManager.UN_ACCEPT)
         {
            if(animatorLevel["BeadsAndSwirl"])
            {
               animatorLevel["BeadsAndSwirl"].visible = false;
            }
            if(conLevel["AltarAndSwirl"])
            {
               conLevel["AltarAndSwirl"].visible = false;
            }
         }
         else
         {
            TasksManager.getProStatusList(1123,function(param1:Array):void
            {
               if(!param1[3])
               {
                  if(animatorLevel["BeadsAndSwirl"])
                  {
                     animatorLevel["BeadsAndSwirl"].visible = false;
                  }
                  if(conLevel["AltarAndSwirl"])
                  {
                     conLevel["AltarAndSwirl"].visible = false;
                  }
               }
            });
         }
         Task1123.initTaskFor744(this);
         CourageTestActivity.init(this);
      }
      
      override public function destroy() : void
      {
      }
   }
}

