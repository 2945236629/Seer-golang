package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_971 extends BaseMapProcess
   {
      
      public function MapProcess_971()
      {
         super();
      }
      
      override protected function init() : void
      {
         getDefinitionByName("com.robot.app2.control.BrightBattleController").initMap971(this);
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.control.BrightBattleController").destroy();
      }
   }
}

