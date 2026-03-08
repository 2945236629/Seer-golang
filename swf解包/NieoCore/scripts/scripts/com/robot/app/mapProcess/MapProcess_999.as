package com.robot.app.mapProcess
{
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_999 extends BaseMapProcess
   {
      
      public function MapProcess_999()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         getDefinitionByName("com.robot.app2.control.ShadowKingVsAosikaController").initMap(this);
         MapListenerManager.add(conLevel["to997"],function():void
         {
            MapManager.changeMap(997);
         },"魔界之门");
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.control.ShadowKingVsAosikaController").destroy();
         super.destroy();
      }
   }
}

