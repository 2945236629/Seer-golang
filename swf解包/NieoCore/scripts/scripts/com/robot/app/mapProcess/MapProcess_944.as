package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task1676;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.info.pet.PetInfo;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.PetManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.ui.alert.Alarm;
   import flash.events.MouseEvent;
   
   public class MapProcess_944 extends BaseMapProcess
   {
      
      private const TASK_ID:int = 1675;
      
      public function MapProcess_944()
      {
         super();
      }
      
      override protected function init() : void
      {
         MapListenerManager.add(this.btnLevel["btnXiaoHuoHou"],this.onClickXiaoHuoHou,"怎样获得小火猴");
         MapListenerManager.add(this.btnLevel["btnYanHuoHou"],this.onClickYanHuoHou,"怎样获得融合精灵");
         MapListenerManager.add(this.btnLevel["btnMoYanXingXing"],this.onClickMoYanXingXing,"怎样获得极品魔焰猩猩");
         MapListenerManager.add(this.btnLevel["btnNew"],this.onClickOpenTrainPanel,"魔焰猩猩特训 点击进入");
         MapListenerManager.add(this.btnLevel["btnYanMo"],this.onClickFightWithBoss,"");
         MapListenerManager.add(this.btnLevel["btnMYXX"],this.onClickOpenTrainPanel,"魔焰猩猩特训 点击进入");
         SocketConnection.send(1022,86061068);
         Task1676.initTaskForMap944(this);
      }
      
      private function onClickXiaoHuoHou(param1:MouseEvent) : void
      {
         SocketConnection.send(1022,86061069);
         ModuleManager.showModule(ClientConfig.getAppModule("HowToGetThreeInitialPetPanel"));
      }
      
      private function onClickYanHuoHou(param1:MouseEvent) : void
      {
         SocketConnection.send(1022,86061070);
         ModuleManager.showModule(ClientConfig.getAppModule("HowToFusionPanel"));
      }
      
      private function onClickMoYanXingXing(param1:MouseEvent) : void
      {
         SocketConnection.send(1022,86061071);
         var _loc2_:PetInfo = PetManager.getPetInfo(PetManager.defaultTime);
         if(Boolean(_loc2_) && _loc2_.id == 309)
         {
            ModuleManager.showModule(ClientConfig.getAppModule("AssessorResultPanel"),"正在打开",_loc2_);
         }
         else
         {
            Alarm.show("请将魔焰猩猩设置为首发精灵！");
         }
      }
      
      private function onClickOpenTrainPanel(param1:MouseEvent) : void
      {
         SocketConnection.send(1022,86061072);
         var _loc2_:PetInfo = PetManager.getPetInfo(PetManager.defaultTime);
         if(Boolean(_loc2_) && _loc2_.id == 309)
         {
            ModuleManager.showModule(ClientConfig.getAppModule("MoyanxingxingTrainPanel"));
         }
         else
         {
            Alarm.show("请将魔焰猩猩设置为首发精灵！");
         }
      }
      
      private function onClickFightWithBoss(param1:MouseEvent) : void
      {
         SocketConnection.send(1022,86061072);
         var _loc2_:PetInfo = PetManager.getPetInfo(PetManager.defaultTime);
         if(Boolean(_loc2_) && _loc2_.id == 309)
         {
            ModuleManager.showModule(ClientConfig.getAppModule("MoyanxingxingTrainPanel"));
         }
         else
         {
            Alarm.show("请将魔焰猩猩设置为首发精灵！");
         }
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}

