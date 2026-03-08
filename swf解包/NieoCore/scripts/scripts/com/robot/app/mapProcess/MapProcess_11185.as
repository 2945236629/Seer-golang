package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_11185 extends BaseMapProcess
   {
      
      public function MapProcess_11185()
      {
         super();
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.RaySoulBattleArmorController").destroy();
      }
      
      override protected function init() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.RaySoulBattleArmorController").init(this);
      }
   }
}

