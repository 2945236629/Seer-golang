package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1652;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.display.MovieClip;
   
   public class MapProcess_10328 extends BaseMapProcess
   {
      
      public function MapProcess_10328()
      {
         super();
      }
      
      override protected function init() : void
      {
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         (conLevel["taskMc"] as MovieClip).gotoAndStop(1);
         TaskController_1652.startState2(this);
      }
      
      override public function destroy() : void
      {
         TaskController_1652.destroy();
         super.destroy();
      }
   }
}

