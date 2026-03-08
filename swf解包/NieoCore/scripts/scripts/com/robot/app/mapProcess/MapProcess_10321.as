package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1595;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.events.MouseEvent;
   
   public class MapProcess_10321 extends BaseMapProcess
   {
      
      public function MapProcess_10321()
      {
         super();
      }
      
      override protected function init() : void
      {
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         TaskController_1595.startState4(this);
      }
      
      private function onClickTargetHandler(param1:MouseEvent) : void
      {
         TaskController_1595.startState4(this);
      }
      
      override public function destroy() : void
      {
         TaskController_1595.destroy();
         super.destroy();
      }
   }
}

