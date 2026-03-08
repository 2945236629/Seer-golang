package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_10882 extends BaseMapProcess
   {
      
      private var cls:*;
      
      public function MapProcess_10882()
      {
         super();
      }
      
      override protected function init() : void
      {
         this.cls = getDefinitionByName("com.robot.app2.control.GiraudHelpFindLostMemorieMap1Controller");
         this.cls.initForMap10882(this);
      }
      
      override public function destroy() : void
      {
         this.cls.destroy();
      }
   }
}

