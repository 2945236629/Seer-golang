package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_946 extends BaseMapProcess
   {
      
      public function MapProcess_946()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         getDefinitionByName("com.robot.app2.mapProcess.control.activityControl.SkullWizardController").initForMap(this);
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.activityControl.SkullWizardController").destroy();
      }
   }
}

