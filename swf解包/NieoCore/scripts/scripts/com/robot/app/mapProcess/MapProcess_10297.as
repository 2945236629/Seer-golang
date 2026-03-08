package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1495;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.events.MouseEvent;
   
   public class MapProcess_10297 extends BaseMapProcess
   {
      
      public function MapProcess_10297()
      {
         super();
      }
      
      override protected function init() : void
      {
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         TasksManager.getProStatusList(TaskController_1495.TASK_ID,function(param1:Array):void
         {
            if(Boolean(param1[1]) && !param1[2])
            {
               MapListenerManager.add(btnLevel["taskClick_mc"],_clickMcHandler,"谱尼");
            }
            else if(Boolean(param1[2]) && !param1[3])
            {
               _clickMcHandler();
            }
         });
      }
      
      private function _clickMcHandler(param1:MouseEvent = null) : void
      {
         TaskController_1495.initForMap10296(this);
      }
      
      override public function destroy() : void
      {
         TaskController_1495.destroy();
      }
   }
}

