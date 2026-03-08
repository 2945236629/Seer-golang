package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_968 extends BaseMapProcess
   {
      
      private var cls:*;
      
      public function MapProcess_968()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = topLevel.mouseEnabled = false;
         getDefinitionByName("com.robot.app2.mapProcess.control.activityControl.WindBattleController").initForMap(this);
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.activityControl.WindBattleController").destroy();
      }
   }
}

