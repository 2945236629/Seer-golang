package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_979 extends BaseMapProcess
   {
      
      private var cls:*;
      
      public function MapProcess_979()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         this.cls = getDefinitionByName("com.robot.app2.mapProcess.control.WeeklyVSController_asidi");
         this.cls.initForMap(this);
      }
      
      override public function destroy() : void
      {
         this.cls.destroy();
         super.destroy();
      }
   }
}

