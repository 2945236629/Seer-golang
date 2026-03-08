package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1505;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.events.MouseEvent;
   
   public class MapProcess_10298 extends BaseMapProcess
   {
      
      public function MapProcess_10298()
      {
         super();
      }
      
      override protected function init() : void
      {
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         TasksManager.getProStatusList(TaskController_1505.TASK_ID,function(param1:Array):void
         {
            if(Boolean(param1[0]) && !param1[1])
            {
               MapListenerManager.add(btnLevel["taskClick_mc"],_clickMcHandler,"赛小息");
            }
            else
            {
               _clickMcHandler();
            }
         });
      }
      
      private function _clickMcHandler(param1:MouseEvent = null) : void
      {
         TaskController_1505.initForMap10298(this);
      }
      
      override public function destroy() : void
      {
         TaskController_1505.destroy();
      }
   }
}

