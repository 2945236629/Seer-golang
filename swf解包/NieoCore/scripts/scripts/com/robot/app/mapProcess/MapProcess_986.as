package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_986 extends BaseMapProcess
   {
      
      private var cls:*;
      
      public function MapProcess_986()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = topLevel.mouseEnabled = false;
         this.cls = getDefinitionByName("com.robot.app2.control.BraveChallengeController");
         this.cls.init(this);
      }
      
      override public function destroy() : void
      {
         this.cls.destroy();
      }
   }
}

