package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_963 extends BaseMapProcess
   {
      
      private var cls:*;
      
      public function MapProcess_963()
      {
         super();
      }
      
      override protected function init() : void
      {
         this.cls = getDefinitionByName("com.robot.app2.mapProcess.control.ChristmasDayActivityController");
         this.cls.init(this);
      }
      
      override public function destroy() : void
      {
         this.cls.destroy();
      }
   }
}

