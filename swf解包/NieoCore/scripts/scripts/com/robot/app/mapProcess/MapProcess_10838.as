package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_10838 extends BaseMapProcess
   {
      
      private var cls:*;
      
      public function MapProcess_10838()
      {
         super();
      }
      
      override protected function init() : void
      {
         this.cls = getDefinitionByName("com.robot.app2.mapProcess.control.VanguardStagingController");
         this.cls.initForMap10838(this);
      }
      
      override public function destroy() : void
      {
      }
   }
}

