package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_10862 extends BaseMapProcess
   {
      
      private var cls:*;
      
      public function MapProcess_10862()
      {
         super();
      }
      
      override protected function init() : void
      {
         this.cls = getDefinitionByName("com.robot.app2.control.GaoStationedDragonVentureController");
         this.cls.initForMap10862(this);
      }
      
      override public function destroy() : void
      {
         this.cls.destroy();
      }
   }
}

