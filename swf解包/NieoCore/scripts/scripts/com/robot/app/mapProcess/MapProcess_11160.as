package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_11160 extends BaseMapProcess
   {
      
      public function MapProcess_11160()
      {
         super();
      }
      
      override protected function init() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.AnHeiJustinBackController").initForStep2(this);
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.AnHeiJustinBackController").destroyForStep2();
      }
   }
}

