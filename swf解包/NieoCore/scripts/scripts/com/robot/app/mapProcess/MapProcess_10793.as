package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_10793 extends BaseMapProcess
   {
      
      public function MapProcess_10793()
      {
         super();
      }
      
      override public function setup() : void
      {
         super.setup();
         getDefinitionByName("com.robot.app2.mapProcess.control.JoinArmyController").initMap(this);
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.JoinArmyController").destroy();
         super.destroy();
      }
   }
}

