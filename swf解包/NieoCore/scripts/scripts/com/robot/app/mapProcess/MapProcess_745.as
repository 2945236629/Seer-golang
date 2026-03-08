package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_745 extends BaseMapProcess
   {
      
      public function MapProcess_745()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         getDefinitionByName("com.robot.app2.mapProcess.control.activityControl.GrassStoneThirdController").initMapFor745(this);
      }
      
      override public function destroy() : void
      {
      }
   }
}

