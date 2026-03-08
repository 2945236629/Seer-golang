package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_10880 extends BaseMapProcess
   {
      
      private var cls:*;
      
      public function MapProcess_10880()
      {
         super();
      }
      
      override protected function init() : void
      {
         this.cls = getDefinitionByName("com.robot.app2.control.GiraudHelpFindLostMemorieMap2Controller");
         this.cls.initForMap10880(this);
      }
      
      override public function destroy() : void
      {
         this.cls.destroy();
      }
   }
}

