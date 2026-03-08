package com.robot.app.mapProcess
{
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.BufferRecordManager;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.utils.CommonUI;
   
   public class MapProcess_995 extends BaseMapProcess
   {
      
      public function MapProcess_995()
      {
         super();
      }
      
      override protected function init() : void
      {
         if(!BufferRecordManager.getMyState(1148))
         {
            BufferRecordManager.setMyState(1148,true);
            AnimateManager.playFullScreenAnimate(ClientConfig.getFullMovie("active_20140509_5"),function():void
            {
            });
         }
         StatManager.sendStat2014("S-觉醒","来到觉醒之地S的",StatManager.RUN_ACT);
         MapListenerManager.add(MapManager.currentMap.controlLevel["gameBtn"],function():void
         {
            CommonUI.removeYellowArrow(MapManager.currentMap.topLevel);
            ModuleManager.showModule(ClientConfig.getAppModule("SBreakthroughGamePanel"));
         },"探索空间");
         MapListenerManager.add(MapManager.currentMap.controlLevel["door"],function():void
         {
            MapManager.changeMap(103);
         },"瞭望露台");
         MapListenerManager.add(MapManager.currentMap.controlLevel["machineBtn"],function():void
         {
            CommonUI.removeYellowArrow(MapManager.currentMap.topLevel);
            ModuleManager.showModule(ClientConfig.getAppModule("SBreakthroughMachinePanel"));
         },"精元觉醒机");
         MapListenerManager.add(MapManager.currentMap.controlLevel["shopBtn"],function():void
         {
            CommonUI.removeYellowArrow(MapManager.currentMap.topLevel);
            ModuleManager.showModule(ClientConfig.getAppModule("SBreakthroughShopPanel"));
         },"觉醒商城");
      }
   }
}

