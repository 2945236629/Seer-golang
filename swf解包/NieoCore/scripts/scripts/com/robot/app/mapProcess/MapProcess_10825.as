package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_10825 extends BaseMapProcess
   {
      
      private var cls:*;
      
      public function MapProcess_10825()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseEnabled = false;
         topLevel.mouseChildren = false;
         this.cls = getDefinitionByName("com.robot.app2.control.FengshenStoneCollectionController");
         this.cls.initForMap3(this);
      }
      
      override public function destroy() : void
      {
         this.cls.destroy();
         super.destroy();
      }
   }
}

