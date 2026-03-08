package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.*;
   import com.robot.app.task.taskscollection.*;
   import com.robot.core.manager.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_671 extends BaseMapProcess
   {
      
      public function MapProcess_671()
      {
         super();
      }
      
      override protected function init() : void
      {
         var map:BaseMapProcess = null;
         map = null;
         map = this;
         conLevel["task_730_1"].visible = false;
         conLevel["arrow"].visible = false;
         conLevel["seerMC"].visible = false;
         conLevel["arrow737"].visible = false;
         conLevel["rockTig"].visible = false;
         conLevel["task746"].visible = false;
         conLevel["arrow746"].visible = false;
         conLevel["light"].visible = false;
         conLevel["task_737_2"].visible = false;
         conLevel["steleMC"].visible = false;
         Task746.initTaskFor671(this);
         TasksManager.getProStatusList(746,function(param1:Array):void
         {
            if(Boolean(param1[2]) && !param1[3])
            {
               return;
            }
            Task_715.getInstance().init(map);
            Task737.initTaskForMap671(map);
            if(TasksManager.getTaskStatus(737) != TasksManager.ALR_ACCEPT)
            {
               Task730.initTaskForMap671(map);
            }
         });
      }
      
      override public function destroy() : void
      {
         Task_715.getInstance().destroy();
         Task730.destroy();
         Task737.destroy();
         Task746.destroy();
      }
   }
}

