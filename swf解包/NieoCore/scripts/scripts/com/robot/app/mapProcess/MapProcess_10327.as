package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1636;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.display.MovieClip;
   
   public class MapProcess_10327 extends BaseMapProcess
   {
      
      public function MapProcess_10327()
      {
         super();
      }
      
      override protected function init() : void
      {
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         (conLevel["taskMc"] as MovieClip).gotoAndStop(1);
         TaskController_1636.startState4(this);
      }
      
      override public function destroy() : void
      {
         TaskController_1636.destroy();
         super.destroy();
      }
   }
}

