package com.robot.app.mapProcess
{
   import com.robot.app.fightLevel.FightPetBagController;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.BufferRecordManager;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_10398 extends BaseMapProcess
   {
      
      public function MapProcess_10398()
      {
         super();
      }
      
      private static function onPetBagHandler(param1:MouseEvent) : void
      {
         FightPetBagController.show();
      }
      
      override protected function init() : void
      {
         MapListenerManager.add(depthLevel["long"],function(param1:MouseEvent):void
         {
            ModuleManager.showModule(ClientConfig.getAppModule("HeilongdianMainPanel"));
         });
         super.init();
         if(BufferRecordManager.getMyState(929) == false)
         {
            depthLevel["long"].visible = false;
            getDefinitionByName("com.robot.app2.control.longKu.GameHeilongdianControl").playPreTask();
         }
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}

