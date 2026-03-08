package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_10836 extends BaseMapProcess
   {
      
      private var cls:*;
      
      public function MapProcess_10836()
      {
         super();
      }
      
      override protected function init() : void
      {
         this.cls = getDefinitionByName("com.robot.app2.mapProcess.control.VanguardStagingController");
         this.cls.initForMap10836(this);
      }
      
      public function onGoto1() : void
      {
         this.cls.changeRandMap();
      }
      
      override public function destroy() : void
      {
      }
   }
}

