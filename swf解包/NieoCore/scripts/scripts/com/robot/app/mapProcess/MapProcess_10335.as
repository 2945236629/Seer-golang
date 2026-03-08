package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1675;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.display.MovieClip;
   
   public class MapProcess_10335 extends BaseMapProcess
   {
      
      public function MapProcess_10335()
      {
         super();
      }
      
      override protected function init() : void
      {
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         (conLevel["taskMc"] as MovieClip).gotoAndStop(1);
         TaskController_1675.startState4(this);
      }
      
      override public function destroy() : void
      {
         TaskController_1675.destroy();
         super.destroy();
      }
   }
}

