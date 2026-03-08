package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_10332 extends BaseMapProcess
   {
      
      public function MapProcess_10332()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         getDefinitionByName("com.robot.app2.mapProcess.control.activityControl.BibaboController").initForPirateFort(this);
      }
      
      override public function destroy() : void
      {
      }
   }
}

