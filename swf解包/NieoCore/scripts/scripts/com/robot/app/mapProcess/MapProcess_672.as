package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.*;
   import com.robot.core.manager.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_672 extends BaseMapProcess
   {
      
      public function MapProcess_672()
      {
         super();
      }
      
      override protected function init() : void
      {
         var map:BaseMapProcess = null;
         map = null;
         map = this;
         topLevel.mouseEnabled = false;
         topLevel.mouseChildren = false;
         conLevel["task_730_2"].visible = false;
         conLevel["task_730_3"].visible = false;
         conLevel["open"].visible = false;
         conLevel["task_737_3"].visible = false;
         conLevel["guide_mc"].visible = false;
         conLevel["petTig"].visible = false;
         conLevel["bloodMc"].visible = false;
         conLevel["task746"].visible = false;
         conLevel["task_741_1"].visible = false;
         Task746.initTaskFor672(this);
         TasksManager.getProStatusList(746,function(param1:Array):void
         {
            if(Boolean(param1[1]) && !param1[2])
            {
               return;
            }
            Task741.initTaskFor672(map);
            if(TasksManager.getTaskStatus(741) != TasksManager.COMPLETE)
            {
               return;
            }
            Task737.initTaskForMap672(map);
            if(TasksManager.getTaskStatus(737) != TasksManager.ALR_ACCEPT)
            {
               Task730.initTaskForMap672(map);
            }
         });
      }
      
      override public function destroy() : void
      {
         Task730.destroy();
         Task737.destroy();
         Task746.destroy();
      }
   }
}

