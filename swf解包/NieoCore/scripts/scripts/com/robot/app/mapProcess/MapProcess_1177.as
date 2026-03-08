package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_1177 extends BaseMapProcess
   {
      
      public function MapProcess_1177()
      {
         super();
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.StrikeFromDarkJustinController").destroy();
      }
      
      override protected function init() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.StrikeFromDarkJustinController").init(this);
      }
   }
}

