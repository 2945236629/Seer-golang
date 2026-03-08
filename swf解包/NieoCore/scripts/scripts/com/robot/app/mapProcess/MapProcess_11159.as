package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_11159 extends BaseMapProcess
   {
      
      public function MapProcess_11159()
      {
         super();
      }
      
      override protected function init() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.AnHeiJustinBackController").initFor11159(this);
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.AnHeiJustinBackController").destroyFor11159();
      }
   }
}

