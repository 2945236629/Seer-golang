package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_10976 extends BaseMapProcess
   {
      
      public function MapProcess_10976()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         getDefinitionByName("com.robot.app2.control.DrawTitanStarMapController").InitForMap(this);
      }
      
      override public function destroy() : void
      {
         super.destroy();
         getDefinitionByName("com.robot.app2.control.DrawTitanStarMapController").Destroy();
      }
   }
}

