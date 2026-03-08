package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1522;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcess_10301 extends BaseMapProcess
   {
      
      public function MapProcess_10301()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         KTool.hideMapAllPlayerAndMonster();
         (conLevel["taskMc"] as MovieClip).gotoAndStop(1);
         (conLevel["taskMc"]["mc1"]["targetBtn"] as MovieClip).buttonMode = true;
         (conLevel["taskMc"]["mc1"]["targetBtn"] as MovieClip).addEventListener(MouseEvent.CLICK,this.onClickTargetHandler);
      }
      
      private function onClickTargetHandler(param1:MouseEvent) : void
      {
         TaskController_1522.startState_3_1(this);
      }
      
      override public function destroy() : void
      {
         TaskController_1522.destroy();
      }
   }
}

