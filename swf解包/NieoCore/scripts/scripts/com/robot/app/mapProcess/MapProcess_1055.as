package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_1055 extends BaseMapProcess
   {
      
      public function MapProcess_1055()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         topLevel.mouseEnabled = false;
         topLevel.mouseChildren = false;
         getDefinitionByName("com.robot.app2.mapProcess.control.MachinePetAssembleController").initMap(this);
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.MachinePetAssembleController").destroy();
         super.destroy();
      }
   }
}

