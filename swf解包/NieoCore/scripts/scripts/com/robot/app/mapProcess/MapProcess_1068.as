package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_1068 extends BaseMapProcess
   {
      
      public function MapProcess_1068()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         getDefinitionByName("com.robot.app2.mapProcess.control.BlackEyebrowController").initForMap();
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}

