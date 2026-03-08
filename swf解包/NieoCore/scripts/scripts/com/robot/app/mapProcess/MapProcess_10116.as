package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_10116 extends BaseMapProcess
   {
      
      public function MapProcess_10116()
      {
         super();
      }
      
      override protected function init() : void
      {
         getDefinitionByName("com.robot.app2.control.MagnumCallController").stepForMap10116();
      }
      
      override public function destroy() : void
      {
      }
   }
}

