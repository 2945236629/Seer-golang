package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1522;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcess_10302 extends BaseMapProcess
   {
      
      public function MapProcess_10302()
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
         this._getStepCom();
      }
      
      private function _getStepCom() : void
      {
         var bool:Boolean = false;
         TasksManager.getProStatusList(TaskController_1522.TASK_ID,function(param1:Array):void
         {
            if(Boolean(param1[2]) && !param1[3])
            {
               changeStartState();
            }
            else
            {
               (conLevel["taskMc"]["mc1"]["targetBtn"] as MovieClip).addEventListener(MouseEvent.CLICK,onClickTargetHandler);
            }
         });
      }
      
      private function changeStartState() : void
      {
         TaskController_1522.startState_4(this);
      }
      
      private function onClickTargetHandler(param1:MouseEvent) : void
      {
         TaskController_1522.startState_3(this);
         (conLevel["taskMc"]["mc1"]["targetBtn"] as MovieClip).removeEventListener(MouseEvent.CLICK,this.onClickTargetHandler);
      }
      
      override public function destroy() : void
      {
         TaskController_1522.destroy();
      }
   }
}

