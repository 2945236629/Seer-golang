package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.info.pet.PetInfo;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.PetManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.ui.alert.Alarm;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcess_941 extends BaseMapProcess
   {
      
      public function MapProcess_941()
      {
         super();
      }
      
      override protected function init() : void
      {
         MapListenerManager.add(this.conLevel["btnThreeGod"],this.onClickThreeGod,"鲁斯王特训");
         MapListenerManager.add(this.conLevel["btnLusiwang"],this.onClickLusiwang,"获得极品鲁斯王");
         MapListenerManager.add(this.conLevel["btnYiu"],this.onClickClickYiu,"怎样获得伊优");
         MapListenerManager.add(this.conLevel["btnYiuda"],this.onClickClickYiuda,"怎样获得融合精灵");
         MapListenerManager.add(this.conLevel["btnYLW"],this.onClickFightWithBoss,"");
         MovieClip(this.conLevel["btnYLW"]).buttonMode = true;
         MapListenerManager.add(this.conLevel["btnLSW"],this.onClickThreeGod,"鲁斯王特训");
         MovieClip(this.conLevel["btnLSW"]).buttonMode = true;
         ToolBarController.showOrHideAllUser(false);
         SocketConnection.send(1022,86060830);
      }
      
      private function onClickThreeGod(param1:MouseEvent) : void
      {
         SocketConnection.send(1022,86060834);
         var _loc2_:PetInfo = PetManager.getPetInfo(PetManager.defaultTime);
         if(Boolean(_loc2_) && _loc2_.id == 306)
         {
            ModuleManager.showModule(ClientConfig.getAppModule("LusiwangTrainPanel"));
         }
         else
         {
            Alarm.show("请将鲁斯王设置为首发精灵！");
         }
      }
      
      private function onClickLusiwang(param1:MouseEvent) : void
      {
         SocketConnection.send(1022,86060833);
         var _loc2_:PetInfo = PetManager.getPetInfo(PetManager.defaultTime);
         if(Boolean(_loc2_) && _loc2_.id == 306)
         {
            ModuleManager.showModule(ClientConfig.getAppModule("AssessorResultPanel"),"正在打开",_loc2_);
         }
         else
         {
            Alarm.show("请将鲁斯王设置为首发精灵！");
         }
      }
      
      private function onClickClickYiu(param1:MouseEvent) : void
      {
         SocketConnection.send(1022,86060831);
         ModuleManager.showModule(ClientConfig.getAppModule("HowToGetThreeInitialPetPanel"));
      }
      
      private function onClickClickYiuda(param1:MouseEvent) : void
      {
         SocketConnection.send(1022,86060832);
         ModuleManager.showModule(ClientConfig.getAppModule("HowToFusionPanel"));
      }
      
      private function onClickFightWithBoss(param1:MouseEvent) : void
      {
         var _loc2_:PetInfo = PetManager.getPetInfo(PetManager.defaultTime);
         if(Boolean(_loc2_) && _loc2_.id == 306)
         {
            FightManager.fightWithBoss("鱼龙王",0);
         }
         else
         {
            Alarm.show("请将鲁斯王设置为首发精灵！");
         }
      }
      
      override public function destroy() : void
      {
         super.destroy();
         ToolBarController.showOrHideAllUser(true);
      }
   }
}

