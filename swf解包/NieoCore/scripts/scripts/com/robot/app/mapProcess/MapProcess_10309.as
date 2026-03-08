package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1545;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcess_10309 extends BaseMapProcess
   {
      
      public function MapProcess_10309()
      {
         super();
      }
      
      override protected function init() : void
      {
         TaskController_1545.gotoWhich(this);
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         (conLevel["taskMc"] as MovieClip).gotoAndStop(1);
         MapListenerManager.add(conLevel["taskMc"],this.onClickTargetHandler);
      }
      
      private function onClickTargetHandler(param1:MouseEvent) : void
      {
         TaskController_1545.taskNow(this);
      }
      
      override public function destroy() : void
      {
         TaskController_1545.destroy();
         super.destroy();
      }
   }
}

