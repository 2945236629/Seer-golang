package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_1023 extends BaseMapProcess
   {
      
      public function MapProcess_1023()
      {
         super();
      }
      
      override protected function init() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.CreatorArmorEvoController").initForMap(this);
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.CreatorArmorEvoController").destroy();
      }
   }
}

